// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(filename) => "¿Deseas descargar ${filename}?";

  static String m1(url) => "Cargando página: ${url}";

  static String m2(filename) => "Descargando ${filename}";

  static String m3(filename) => "Importando ${filename}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogDownloadQuestion": m0,
        "appTitle": MessageLookupByLibrary.simpleMessage("eXeReader"),
        "composeLbSearchHint":
            MessageLookupByLibrary.simpleMessage("Nombre del proyecto "),
        "composeLbSearchTool": MessageLookupByLibrary.simpleMessage("Buscar"),
        "composeMsgDeleteWarning": MessageLookupByLibrary.simpleMessage(
            "No puedes eliminar un proyecto si estás en el modo de búsqueda. Elimina los criterios de búsqueda para poder borrar."),
        "debugLoadingPage": m1,
        "downloaderDownloading": m2,
        "downloaderImporting":
            MessageLookupByLibrary.simpleMessage("Importando proyecto"),
        "drawerCredits": MessageLookupByLibrary.simpleMessage("Créditos"),
        "drawerHelp": MessageLookupByLibrary.simpleMessage("Ayuda"),
        "drawerHome": MessageLookupByLibrary.simpleMessage("Inicio"),
        "drawerSuggestions":
            MessageLookupByLibrary.simpleMessage("Sugerencias"),
        "errorDownloadResource": MessageLookupByLibrary.simpleMessage(
            "Error al descargar el recurso. Tal vez sea de acceso restringido."),
        "errorImportProject":
            MessageLookupByLibrary.simpleMessage("Error al importar el recurso"),
        "floatingImport": m3,
        "floatingOptionCEDECResources":
            MessageLookupByLibrary.simpleMessage("Recursos CEDEC"),
        "floatingOptionDownloadResources":
            MessageLookupByLibrary.simpleMessage("Descargar recurso"),
        "floatingOptionImportResource":
            MessageLookupByLibrary.simpleMessage("Abrir recurso"),
        "floatingUrl2InputTitle": MessageLookupByLibrary.simpleMessage(
            "Introduce el tipo de enlace y URL del recurso"),
        "floatingUrlErrorContent": MessageLookupByLibrary.simpleMessage(
            "La URL introducida no contiene un proyecto válido"),
        "floatingUrlErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
        "floatingUrlInputTitle": MessageLookupByLibrary.simpleMessage(
            "Introduce la URL del recurso"),
        "genericAuthor": MessageLookupByLibrary.simpleMessage("Autor"),
        "genericBtAccept": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "genericBtCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "genericBtDelete": MessageLookupByLibrary.simpleMessage("Borrar"),
        "genericDeletedProject":
            MessageLookupByLibrary.simpleMessage("Proyecto eliminado"),
        "genericDescription":
            MessageLookupByLibrary.simpleMessage("Descripción"),
        "genericDetails": MessageLookupByLibrary.simpleMessage("Detalles"),
        "genericDownload": MessageLookupByLibrary.simpleMessage("Descargar"),
        "genericLbSearch": MessageLookupByLibrary.simpleMessage("Buscar"),
        "genericLbWarning": MessageLookupByLibrary.simpleMessage("Atención"),
        "genericLongTapToShowDescription": MessageLookupByLibrary.simpleMessage(
            "Mantén pulsado para ver la descripción"),
        "genericNoDeletedProject": MessageLookupByLibrary.simpleMessage(
            "El proyecto no fue eliminado"),
        "genericNotifications":
            MessageLookupByLibrary.simpleMessage("Notificaciones"),
        "helpPart01": MessageLookupByLibrary.simpleMessage(
            "eXeReader es un aplicación que sirve para leer contenidos creados con eXeLearning (exelearning.net). \n\nEsta aplicación libre y gratuita, con licencia GPL2+, permite visualizar proyectos creados con eXeLearning y exportados como sitio web (archivo comprimido zip)."),
        "helpPart02": MessageLookupByLibrary.simpleMessage(
            "Tenemos distintas opciones para cargar un proyecto (archivo comprimido zip) en eXeReader: \n\n- \"Recursos Cedec\". Podemos descargar recursos directamente desde la web de Cedec, seleccionando la opción \"Opciones de descarga\" > \"Descarga de recurso\" del recurso que elijamos. \n\n- \"Descargar recurso\". Podemos indicar la URL directa de un archivo o el enlace de Drive, Dropbox o OneCloud/NextCloud en el que tengamos alojado el archivo zip. \n\n- \"Abrir recurso\". Podemos cargar un proyecto que ya tenemos descargado en nuestro dispositivo."),
        "helpPart03": MessageLookupByLibrary.simpleMessage(
            "En la barra superior encontramos dos iconos. El de la izquierda muestra el menú y el de la derecha abre la barra de búsqueda de proyectos."),
        "helpPart04": MessageLookupByLibrary.simpleMessage(
            "En el menú lateral encontramos varias opciones. La primera nos lleva a la lista de proyectos. \n\n El resto contiene información sobre la aplicación. Te animamos a leerla."),
        "helpPart05": MessageLookupByLibrary.simpleMessage(
            "El buscador de proyectos permite encontrar proyectos ya cargados en la aplicación."),
        "helpPart06": MessageLookupByLibrary.simpleMessage(
            "Para eliminar un proyecto debemos deslizarlo hacia un lateral."),
        "helpPart07": MessageLookupByLibrary.simpleMessage(
            "Para ver la descripción de un proyecto solo tenemos que mantener pulsado el proyecto deseado."),
        "license": MessageLookupByLibrary.simpleMessage("Licencia"),
        "loadingResources":
            MessageLookupByLibrary.simpleMessage("Cargando recursos..."),
        "questionDeleteProject": MessageLookupByLibrary.simpleMessage(
            "¿Quieres eliminar este proyecto?"),
        "resourceAdded": MessageLookupByLibrary.simpleMessage(
            "Recurso añadido correctamente.\n\nNombre: "),
        "resourceDuplicate": MessageLookupByLibrary.simpleMessage(
            "El recurso ya se había importado"),
        "resourceNoFound": MessageLookupByLibrary.simpleMessage(
            "No se han encontrado proyectos con los criterios de búsqueda aplicados"),
        "resourceNotValid":
            MessageLookupByLibrary.simpleMessage("El recurso no es válido. Tal vez no sea un zip creado con eXeLearning."),
        "resourceNotValidZipExtension": MessageLookupByLibrary.simpleMessage(
            "El recurso no es válido. Debe ser archivo con extensión .zip"),
        "subjectEmail": MessageLookupByLibrary.simpleMessage(
            "Contacto desde App eXeReader"),
        "title": MessageLookupByLibrary.simpleMessage("Título"),
        "titleHelpPart02":
            MessageLookupByLibrary.simpleMessage("Cargar proyectos"),
        "titleHelpPart03":
            MessageLookupByLibrary.simpleMessage("Barra superior"),
        "titleHelpPart04": MessageLookupByLibrary.simpleMessage("Menú lateral"),
        "titleHelpPart05":
            MessageLookupByLibrary.simpleMessage("Buscar proyectos"),
        "titleHelpPart06":
            MessageLookupByLibrary.simpleMessage("Eliminar proyectos"),
        "titleHelpPart07":
            MessageLookupByLibrary.simpleMessage("Ver descripción")
      };
}
