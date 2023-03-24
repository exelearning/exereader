import 'dart:io';

import 'package:exereader/helper/project_metadata.dart';
import 'package:exereader/helper/streams.dart';
import 'package:exereader/helper/widgetGenerator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:html/parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart';
import 'package:archive/archive.dart' as Archive;

import '../data/database.dart';
import '../generated/l10n.dart';
import 'constants.dart';

String? getAppHashCodeByPath(path) {
  String searchS = "/Application/";
  if (path.contains(searchS)) {
    int posI = path.indexOf(searchS) + searchS.length;
    int postF = path.indexOf("/", posI + 1);
    String appHashCode = path.substring(posI, postF);
    return appHashCode;
  }
  return null;
}

String getFolderProjectsPath() {
  return (documentsDirectory != null) ? "${documentsDirectory?.path}$projectsRelativePath" : "";
}

String getDocumentsDirectory() {
  return (documentsDirectory != null) ? "${documentsDirectory?.path}" : "";
}

String? getValueXmlElementByKey(String key, Iterable<XmlElement> elementsStringSearch) {
  Iterable<XmlElement> elementsSearch = elementsStringSearch.where((e) => e.getAttribute('value') == key);
  if (elementsSearch.isNotEmpty) {
    XmlElement elementKey = elementsSearch.first;
    XmlElement? elementValue = elementKey.nextElementSibling;
    return elementValue?.getAttribute("value")?.toString().trim();
  }
  return null;
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path);
  return (mimeType?.startsWith('image/')) ?? false;
}

bool isValidPortadaImage(String storageName) {
  storageName = storageName.toLowerCase();

  /*if (!storageName.endsWith(".jpeg") && !storageName.endsWith(".jpg") && !storageName.endsWith(".png")) {
    return false;
  }*/

  List<String> exludeNamesPortada = ["icon_", "popup_bg", "licenses", "88x31"];
  for (String exname in exludeNamesPortada) {
    if (storageName.contains(exname)) {
      return false;
    }
  }
  return true;
}

Future<String?> getPortadaPath(Iterable<XmlElement> elementsStringSearch, String projectName) async {
  try {
    Iterable<XmlElement> elementsSearch = elementsStringSearch.where((e) => e.getAttribute('value') == "_storageName");
    if (elementsSearch.isNotEmpty) {
      for (XmlElement xmlElement in elementsSearch) {
        String? portadaImg = xmlElement.nextElementSibling?.getAttribute("value")?.toString().trim();
        if (portadaImg != null && isValidPortadaImage(portadaImg)) {
          String portadaPath = "$projectsRelativePath$projectName/$portadaImg";
          String portadaFullPath = "${getDocumentsDirectory()}$portadaPath";
          if (await File(portadaFullPath).exists() && isImage(portadaFullPath)) {
            return portadaPath;
          }
        }
      }
    }
  } catch (e) {}
  return null;
}

Future<ProjectMetadata?> getProjectMetadata(Iterable<XmlElement> elementsStringSearch, String projectName) async {
  try {
    String? title = getValueXmlElementByKey('_title', elementsStringSearch);
    String? author = getValueXmlElementByKey('_author', elementsStringSearch);
    String? description = getValueXmlElementByKey('_description', elementsStringSearch);
    String? license = getValueXmlElementByKey('license', elementsStringSearch);
    String? portada = await getPortadaPath(elementsStringSearch, projectName);
    return ProjectMetadata(title, author, description, license, portada);
  } catch (e) {}
  return null;
}

Future<String?> insertProjectDB(String projectName) async {
  try {
    final dbHelper = DatabaseHelper.instance;

    //Directory projectDirectory = Directory('${getFolderProjectsPath()}$projectName');
    String projectRelativePath = "$projectsRelativePath$projectName";
    String indexProjectRelativePath = "$projectRelativePath/index.html"; //este es el que se guarda en bbdd
    String indexUrl = "${getDocumentsDirectory()}$indexProjectRelativePath";
    String contentv3Url = "${getDocumentsDirectory()}$projectRelativePath/contentv3.xml";

    String title = projectName;
    String? author;
    String? description;
    String? license;
    String? portada;

    ProjectMetadata? projectMetadata;

    File contentv3File = await File(contentv3Url);
    if (await contentv3File.exists()) {
      Iterable<XmlElement>? elementsStringSearch;
      try {
        //Lectura del xml contentv3.xml
        String contentv3FileXmlS = await contentv3File.readAsString();
        XmlDocument xmlDocument = XmlDocument.parse(contentv3FileXmlS);
        elementsStringSearch = xmlDocument.findAllElements('string');
      } catch (e) {}

      if (elementsStringSearch != null && elementsStringSearch.isNotEmpty) {
        projectMetadata = await getProjectMetadata(elementsStringSearch, projectName);
        if (projectMetadata != null) {
          title = projectMetadata.getTitle() ?? projectName;
          author = projectMetadata.getAuthor() ?? "";
          description = projectMetadata.getDescription() ?? "";
          license = projectMetadata.getLicense() ?? "";
          portada = projectMetadata.getPortada() ?? "";
        }
      }
    }

    if (projectMetadata == null) {
      //Lectura del index.html (en caso de fallo en xml de metadata), forma antigua
      String fileIndexToString = await File(indexUrl).readAsString();
      var document = parse(fileIndexToString);
      var elementList = document.getElementsByTagName("title");
      if (elementList.isNotEmpty) {
        title = document.getElementsByTagName("title")[0].innerHtml;
      }
      author = document.querySelector('[name="author"]')?.attributes['content'];
      description = document.querySelector('[name="description"]')?.attributes['content'];
      license = "";
    }

    author ??= "";
    description ??= "";
    license ??= "";
    portada ??= "";

    int id = await dbHelper.insert(<String, dynamic>{
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnDescription: description,
      DatabaseHelper.columnAuthor: author,
      DatabaseHelper.columnPath: indexProjectRelativePath, //ruta relativa siempre /projects/xxxx
      DatabaseHelper.columnLicense: license,
      DatabaseHelper.columnPortada: portada
    });

    //Guardamos en memoria en varios arrays
    ids.add(id);
    uris.add(indexUrl);
    projectsName.add(title);
    //---

    int countA = projects.length;
    GestureDetector projectGD = createProjectGestureDetection(countA, title, author, description, indexUrl, license, portada);
    project.add(projectGD);

    return title;
  } catch (e) {
    //print(e);
  }
  return null;
}

Future<void> importProjectFromZip(String zipPath) async {
  BuildContext context = contextHome!;

  final File zip = File(zipPath);
  if (!await zip.exists()) {
    Navigator.of(context).pop(); //Cerramos dialogo de progreso (siempre venimos con un dialogo abierto)
    showImportErrorDialog();
    return;
  }

  final String documentsDirectory = getDocumentsDirectory();
  bool validResource = false;
  bool errorInDatabase = false;

  final String projectName = basename(zip.path).split(".")[0];

  final String projectsAbsolutePath = "$documentsDirectory$projectsRelativePath";
  final String projectRelativePath = "$projectsRelativePath$projectName";
  final String projectAbsolutePath = "$documentsDirectory$projectRelativePath";
  final String indexProjectRelativePath = "$projectRelativePath/index.html"; //este es el que se guarda en bbdd
  final String indexProjectAbsolutePath = "$documentsDirectory$indexProjectRelativePath";

  Directory projectDirectory = Directory(projectAbsolutePath);

  try {

    /* Check if project already exists */
    if (await projectDirectory.exists()) {
      await zip.delete(); //borrar zip
      Navigator.of(context).pop();
      showResourceDuplicateDialog();
      return;
    } else {
      try {
        /* Descomprimir zip
        In some cases, the imported resource can contain all the elements in its root or,
        on the contrary, it can contain a folder with the same name as the zip where it stores them,
        that is why two different paths must be specified to expand compatibility.
        */
        Directory? unZip;
        if (Archive.ZipDecoder().decodeBytes(zip.readAsBytesSync())[0].name.split("/")[0] == projectName) {
          unZip = Directory(projectsAbsolutePath);
        } else {
          unZip = Directory(projectAbsolutePath);
        }

        await ZipFile.extractToDirectory(zipFile: zip, destinationDir: unZip);

      } catch (e) {}

      //Comprobar que se ha descomprimido bien y tiene fichero index.html en su interior
      validResource = await File(indexProjectAbsolutePath).exists();
      if(validResource){
        //Recurso Válido OK
        String? title = await insertProjectDB(projectName);
        if (title != null) {
          //Inserción en BBDD OK
          Navigator.of(context).pop();
          showResourceAddedSnackBar(title);
        }
        else{
          //Inserción en BBDD KO
          validResource = false;
          errorInDatabase = true;
        }
      }
    }
  } catch (e) {
    validResource = false;
  }

  //Clean resources
  if (await zip.exists()) {
    //siempre borramos zip
    await zip.delete();
  }

  if(!validResource){
    //Recurso NO Válido KO
    //Borrar carpeta descomprimida
    if (projectName.isNotEmpty) {
      if (await projectDirectory.exists()) {
        await projectDirectory.delete(recursive: true);
      }
    }
    Navigator.of(context).pop(); //Cerrar dialogo de progreso

    (errorInDatabase) ?  showImportErrorDialog() : showResourceNotValidDialog();
  }

}

void showResourceDuplicateDialog() {
  BuildContext context = contextHome!;
  showGenericDialog("Error", S.of(context).resourceDuplicate);
}

void showResourceNotValidDialog() {
  BuildContext context = contextHome!;
  showGenericDialog("Error", S.of(context).resourceNotValid);
}

void showImportErrorDialog() {
  BuildContext context = contextHome!;
  showGenericDialog("Error", S.of(context).errorImportProject);
}

void showGenericDialog(String title, String content) {
  BuildContext context = contextHome!;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(title: Text(title), content: Text(content), actions: <Widget>[
        MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.green, //(MediaQuery.of(context).platformBrightness == Brightness.dark) ? Colors.green : Colors.blue,
            child: Text(S.of(context).genericBtAccept))
      ]));
}

Future<void> removeProject(int index) async {
  final dbHelper = DatabaseHelper.instance;

  String uriDelete = uris[index]; //ya viene uri absoluta
  int idProject = ids[index];

//Remove de los arrays (el de projects o projectssearch que faltan se hacen al cambiar de estado en home.dart removeProjectDialog)
  ids.removeAt(index);
  uris.removeAt(index);
  projectsName.removeAt(index);

//Remove de bbdd
  dbHelper.delete(idProject);

//Remove directorio fisica
  Directory directoryRemove = Directory(File(uriDelete).parent.path);
  if (await directoryRemove.exists()) {
    await directoryRemove.delete(recursive: true);
  }
}

void showResourceAddedSnackBar(String title) {
  BuildContext context = contextHome!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(S.of(context).resourceAdded + title, style: const TextStyle(color: Colors.white)),
        duration: const Duration(milliseconds: 4600),
        backgroundColor: Colors.green),
  );
}
