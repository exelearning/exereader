import 'package:flutter/material.dart';
import 'package:exereader/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:exereader/Drawer/drawer.dart';
import 'package:exereader/helper/constants.dart';
import 'package:exereader/pages/home.dart';
import 'package:exereader/floating_action_button/floating_button.dart';

import 'helper/streams.dart';

import 'package:diacritic/diacritic.dart';


/**
 * This class contains the assembly with all the widgets that make up the main
 * screen and the root of the entire application.
 */

class ExeReader extends StatelessWidget {
  const ExeReader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "eXeReader",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      //internationalization
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const ExeReaderBodyApp(),
    );
  }
}

class ExeReaderBodyApp extends StatefulWidget {
  const ExeReaderBodyApp({Key? key}) : super(key: key);

  @override
  ExeReaderBodyAppState createState() => ExeReaderBodyAppState();
}

class ExeReaderBodyAppState extends State<ExeReaderBodyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        backgroundColor: Colors.green,
        actions: <Widget>[buttonSearch(context)],
      ),
      drawer: const DrawerNav(),
      body: HomeListView(project: project.stream),
      floatingActionButton: FloatingButton(),
    );
  }

  // This method returns an overloaded button, which has the ability
  // to add search criteria or delete existing criteria.
  IconButton buttonSearch(BuildContext context) {
    return IconButton(
      icon: Icon((isSearch) ? Icons.search_off : Icons.search),
      onPressed: () {
        if (!isSearch) {
          showDialog(context: context, builder: (_) => dialogSearch(context));
        } else {
          setState(() {
            isSearch = false;
            projectsSearch = [];
            valueSearch = "";
          });
        }
      },
    );
  }

  // This method returns the dialog which asks the user for the search
  // parameters and forms a list with the obtained criteria.
  AlertDialog dialogSearch(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).composeLbSearchTool),
      content: TextField(
        onChanged: (value) {
          valueSearch = value;
        },
        decoration: InputDecoration(hintText: S.of(context).composeLbSearchHint),
      ),
      actions: <Widget>[
        MaterialButton(
            onPressed: () {
              if (valueSearch.isEmpty) {
                Navigator.of(context).pop();
                return;
              }

              setState(() {
                projectsSearch = [];
                isSearch = true;

                String valueSearchFormat =  removeDiacritics(valueSearch.toLowerCase()).trim();

                projectsName.forEach((element) {
                  if (removeDiacritics(element.toLowerCase()).contains(valueSearchFormat)) {
                    var index = projectsName.indexOf(element);
                    projectsSearch.add(projects[index]);
                  }
                });
                Navigator.of(context).pop();

                if(projectsSearch.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).resourceNoFound),
                      duration: const Duration(milliseconds: 4500),
                    ),
                  );
                }

                //NO mostrar dialogo de advertencia, no es necesario, ahora es posible borrar proyecto en modo búsqueda
                /*showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(S.of(context).genericLbWarning),
                          content: Text(S.of(context).composeMsgDeleteWarning),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  S.of(context).genericBtAccept,
                                  style: const TextStyle(color: Colors.green),
                                ))
                          ],
                        ));*/
              });
            },
            child: Text(
              S.of(context).genericLbSearch,
              style: const TextStyle(color: Colors.green),
            )),
      ],
    );
  }
}
