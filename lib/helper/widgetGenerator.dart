import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../pages/web_view.dart';
import 'constants.dart';
import 'functions.dart';

GestureDetector createProjectGestureDetection(
    int countA, String name, String author, String description, String path, String? license, String? portadaPath) {
  BuildContext context = contextHome!;

  const Color colorImpar = Colors.transparent;
  const Color colorPar = Colors.transparent;
  /*if(MediaQuery.of(context).platformBrightness == Brightness.dark){ }*/

  license ??= "";

  bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

  File? portadaFile = (portadaPath != null && portadaPath.isNotEmpty) ? File("${getDocumentsDirectory()}$portadaPath") : null;
  Widget projectIcon = (portadaFile == null)
      ? const Icon(size: 38, Icons.folder)
      : SizedBox(
          width: 38,
          height: 38,
          child: CircleAvatar(
              backgroundImage: FileImage(portadaFile), backgroundColor: Colors.transparent /*(isDark) ? const Color(0xFF475e45) : Colors.white*/));

  return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(S.of(context).genericDetails),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text("${S.of(context).title}: $name"),
                        const Text("\n"),
                        Text("${S.of(context).genericAuthor}: $author"),
                        const Text("\n"),
                        Text("${S.of(context).genericDescription}: $description"),
                        const Text("\n"),
                        Text("${S.of(context).license}: $license"),
                        const Text("\n")
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                        textColor: Colors.green, //(MediaQuery.of(context).platformBrightness == Brightness.dark) ? Colors.green : Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(S.of(context).genericBtAccept))
                  ],
                ));
      },
      child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
          //Title
          title: Text(name),
          //Subtitle
          subtitle: Text(S.of(context).genericLongTapToShowDescription),
          //Icon
          //leading: const Icon(Icons.folder),
          leading: projectIcon,
          onTap: () {
            //Navigator.of(context).push(Transition(pagina: WebViewWidget(url: path)));
            //Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewWidget(url: path)));
            Navigator.push(context, CupertinoPageRoute(builder: (context) => WebViewWidget(url: path, title: name), title: name));
          },
          tileColor: countA.isEven ? colorPar : colorImpar,
          splashColor: countA.isEven ? Colors.lightGreenAccent.shade100 : Colors.greenAccent.shade100));
}
