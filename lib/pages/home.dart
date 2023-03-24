import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exereader/data/database.dart';
import 'package:exereader/helper/constants.dart';
import 'package:exereader/helper/route_animaton.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../help/help_page.dart';
import '../helper/functions.dart';
import '../helper/widgetGenerator.dart';

/**
 * HomeListView
 *
 * Class with all the projects uploaded by the user and displayed
 * in the form of a ListView for clicking and viewing
 */

class HomeListView extends StatefulWidget {
  const HomeListView({Key? key, required this.project}) : super(key: key);

  final Stream<Widget> project;

  @override
  HomeListState createState() => HomeListState();
}

class HomeListState extends State<HomeListView> {
  //Instance of DataBase
  final dbHelper = DatabaseHelper.instance;

  bool firstloadProjectsOfMemory = true;

  void firstInitAppActions() async {
    //Launch the app help if it is the first time it is running on the device
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("first_time") ?? true) {
      Navigator.of(context).push(Transition(pagina: HelpPage()));
      preferences.setBool("first_time", false);
    }
  }

  void initAppActions() async {
    documentsDirectory = await getApplicationDocumentsDirectory();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    int countProjects = await loadProjectsOfMemory();
    firstloadProjectsOfMemory = false;
    if (countProjects == 0) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    resetProjectsOfMemory();

    Future.delayed(Duration.zero, () async {
      firstInitAppActions();
      initAppActions();
    });

    widget.project.listen((event) {
      addProject(event);
    });
  }

  Widget build(BuildContext context) {
    contextHome = context;

    if (projects.isNotEmpty) {
      return showProjectList();
    } else if (!firstloadProjectsOfMemory) {
      return showImageEmptyList(context);
    }

    return Container(alignment: Alignment.center, child: Text(S.of(context).loadingResources));
  }

  //This method read data contains on Sqlite Database
  //and generates the elements of list with information read
  Future<int> loadProjectsOfMemory() async {
    final int? countRows = await dbHelper.queryRowCount();
    int countA = 0;
    if (countRows! > 0) {
      final List<Map<String, dynamic>> rows = await dbHelper.queryAllRows();
      for (var element in rows) {
        String path = getDocumentsDirectory() + element[DatabaseHelper.columnPath]; //path absoluto

        ids.add(element[DatabaseHelper.columnId]);
        uris.add(path);
        projectsName.add(element[DatabaseHelper.columnName]);

        GestureDetector projectGD = createProjectGestureDetection(countA, element[DatabaseHelper.columnName], element[DatabaseHelper.columnAuthor],
            element[DatabaseHelper.columnDescription], path, element[DatabaseHelper.columnLicense], element[DatabaseHelper.columnPortada]);
        addProject(projectGD);

        countA++;
      }
    }

    return countA;
  }

  // This method returns a list of projects depending on the criteria set:
  /*
  - If no criteria were established, it will return all the projects that
    the user has imported

  - If the user applies search criteria, he will return a list with
    the projects that contain the established criteria in their name

    Each project is wrapped in a disposable widget that allows a swipe to remove it
   from the list of projects imported by the user.
   */
  ListView showProjectList() {
    return ListView.separated(
        itemCount: (isSearch) ? projectsSearch.length : projects.length,
        reverse: false,
        separatorBuilder: (context, index) => const Divider(color: Colors.green, indent: 6, endIndent: 6, height: 0),
        itemBuilder: (BuildContext context, index) {
          //Buscar index del listado principal
          int indexFinal = -1;
          GestureDetector? projectGd;
          if (isSearch) {
            projectGd = projectsSearch[index] as GestureDetector;
          } else {
            projectGd = projects[index] as GestureDetector;
          }

          ListTile projectLt = projectGd.child as ListTile;
          String projectName = (projectLt.title as Text).data ?? "";
          if (projectName.isNotEmpty && projectsName.contains(projectName)) {
            int indexProject = projectsName.indexWhere((item) => item == projectName);
            if (indexProject >= 0) {
              indexFinal = indexProject;
            }
          }

          /*if (isSearch) {
          return projectsSearch[index];
        }else */
          if (indexFinal == -1) {
            return projectGd;
          } else {
            return Dismissible(
                key: Key(UniqueKey().toString()),
                onDismissed: (direction) {
                  setState(() {
                    showDialog(context: context, builder: (_) => removeProjectDialog(context, indexFinal, index));
                  });
                },
                background: Container(
                    color: Colors.red,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).genericBtDelete,
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: Colors.white)))),
                child: Material(color: index.isEven ? Colors.transparent : const Color(0x2B475e45), child: projectGd));
          }
        });
  }

  // This method show an alert dialog with options related with remove project
  AlertDialog removeProjectDialog(BuildContext context, int index, int indexSearch) {
    return AlertDialog(
      title: Text(S.of(context).genericNotifications),
      content: Text(S.of(context).questionDeleteProject),
      actions: <Widget>[
        MaterialButton(
            textColor: Colors.green,
            onPressed: () {
              Future.delayed(Duration.zero, () async {
                await removeProject(index);
              });

              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).genericDeletedProject),
                  duration: const Duration(milliseconds: 1000),
                ),
              );

              //Refresh view
              setState(() {
                //Remove de los arrays de project de la lista principal y de la de búsqueda si fuera necesario
                projects.removeAt(index);
                if (isSearch) {
                  //el index de la lista de búsqueda puede no cuadrar con el de la lista principal
                  projectsSearch.removeAt(indexSearch);
                }
              });
            },
            child: Text(S.of(context).genericBtAccept)),
        MaterialButton(
            textColor: Colors.red,
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).genericNoDeletedProject),
                    duration: const Duration(milliseconds: 1000),
                  ),
                );
              });
            },
            child: Text(S.of(context).genericBtCancel)),
      ],
    );
  }

  Container showImageEmptyList(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
        alignment: Alignment.center,
        child: Image(
            image: AssetImage((isPortrait)
                ? (Localizations.localeOf(context).languageCode == "es")
                    ? "assets/home/home_es.png"
                    : "assets/home/home_en.png"
                : (Localizations.localeOf(context).languageCode == "es")
                    ? "assets/home/home_land_es.png"
                    : "assets/home/home_land_en.png")));
  }

  // This method insert the project in the projects list provided with the
  // floating button
  void addProject(Widget project) {
    if(mounted){
      setState(() {
        projects.add(project);
      });
    }
  }

  void resetProjectsOfMemory() {
    projects.clear();
    projectsSearch.clear();
    ids.clear();
    uris.clear();
    projectsName.clear();
    isSearch = false;
  }
}
