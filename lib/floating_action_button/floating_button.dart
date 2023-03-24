//Dart's Libraries
import 'package:exereader/custom_icon/my_flutter_app_icons.dart';
import 'package:exereader/helper/downloader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:exereader/helper/constants.dart';
import 'package:exereader/pages/web_view.dart';
import 'package:flutter/src/widgets/text.dart' as Text;
import 'package:path/path.dart';

import '../generated/l10n.dart';
import '../helper/functions.dart';
import '../helper/url_downloader.dart';

/*
  This widget controls the home screen floating button,
  it is visible only on the home screen.
 */

class FloatingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      spacing: 6,
      spaceBetweenChildren: 6,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
          child: _currIndex == 0
              ? const Icon(Icons.add, key: ValueKey('icon1'))
              : const Icon(
                  Icons.close,
                  key: ValueKey('icon2'),
                )),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      onOpen: () {
        setState(() {
          _currIndex = 1;
        });
      },
      onClose: () {
        setState(() {
          _currIndex = 0;
        });
      },
      children: [
        SpeedDialChild(
            child: const Icon(Icons.file_copy_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () {
              addNewProject(context);
            },
            label: S.of(context).floatingOptionImportResource),
        SpeedDialChild(
            child: const Icon(Icons.download),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () {
              //addFromCedecWebResources(context);
              notifyParent() {
                setState() {}
              }

              addFromUrl(context, notifyParent());
            },
            label: S.of(context).floatingOptionDownloadResources),
        SpeedDialChild(
            child: const Icon(MyFlutterApp.CEDEC),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () {
              addFromCedecWebResources(context);
            },
            label: S.of(context).floatingOptionCEDECResources),
      ],
    );
  }

  void addFromCedecWebResources(BuildContext context) async {
    String title = S.of(context).floatingOptionCEDECResources;
    /*Navigator.of(context)
        .push(Transition(pagina: WebViewWidget(url: "https://cedec.intef.es/recursos/", title: title)));*/
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => WebViewWidget(url: "https://cedec.intef.es/recursos/", title: title), title: title));
  }

  void addFromUrl(context, notifyParent) {
    String tipoURL = TiposUrls.GoogleDrive.valor;
    String url = "";

    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: TiposUrls.GoogleDrive.valor, child: Text.Text(TiposUrls.GoogleDrive.valor)),
      DropdownMenuItem(value: TiposUrls.Dropbox.valor, child: Text.Text(TiposUrls.Dropbox.valor)),
      DropdownMenuItem(value: TiposUrls.OwnCloudNextCloud.valor, child: Text.Text(TiposUrls.OwnCloudNextCloud.valor)),
      DropdownMenuItem(value: TiposUrls.UrlDirecta.valor, child: Text.Text(TiposUrls.UrlDirecta.valor))
      /*const DropdownMenuItem(value: "OneDrive", child: Text.Text("OneDrive")),*/
    ];

    StatefulBuilder statefulBuilderDialogWidget = StatefulBuilder(builder: (BuildContext context, state) {
      /*print("StatefulBuilder addFromUrl");
      print("_tipoURL: " + _tipoURL);
      print("_url: " + _url);*/

      return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(children: [
          Flexible(
              child: DropdownButton(
            value: tipoURL,
            items: menuItems,
            onChanged: (Object? value) {
              state(() {
                //set state will update UI and State of your App
                tipoURL = value as String; //change tipoUrl to new value
              });
            },
          ))
        ]),
        Row(children: [
          Flexible(
              child: TextField(
            onChanged: (value) {
              url = value;
            },
            decoration: const InputDecoration(hintText: "URL"),
          ))
        ])
      ]);
    });

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text.Text(S.of(context).floatingUrl2InputTitle),
              content: statefulBuilderDialogWidget,
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      InfoDownloadUrl? infoDownloadUrl = getInfoDownloadUrl(tipoURL, url.trim());

                      if (infoDownloadUrl != null) {
                        downloadFile(infoDownloadUrl.getUrl(), infoDownloadUrl.getTitle(), notifyParent);
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text.Text(S.of(context).floatingUrlErrorTitle),
                                content: Text.Text(S.of(context).floatingUrlErrorContent),
                                actions: <Widget>[
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text.Text(S.of(context).genericBtAccept, style: const TextStyle(color: Colors.green))),
                                ],
                              );
                            });
                      }
                    },
                    child: Text.Text(
                      S.of(context).genericBtAccept,
                      style: const TextStyle(color: Colors.green),
                    )),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text.Text(
                      S.of(context).genericBtCancel,
                      style: const TextStyle(color: Colors.red),
                    ))
              ],
            ));
  }
}

showDialogResourceNotValidZipExtension() {
  BuildContext context = contextHome!;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: const Text.Text("Error"),
            content: Text.Text(S.of(context).resourceNotValidZipExtension),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Colors.green, //(MediaQuery.of(context).platformBrightness == Brightness.dark) ? Colors.green : Colors.blue,
                  child: Text.Text(S.of(context).genericBtAccept))
            ],
          ));
}

// addNewProject
//
// Call a file picker's menu and user choose a file with a eXe's project
void addNewProject(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final zipPath = result.files.single.path.toString();

    if (!zipPath.contains(".zip")) {
      showDialogResourceNotValidZipExtension();
      return;
    }

    final appName = basename(zipPath).split(".")[0];

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text.Text(S.of(context).floatingImport(appName)),
              content: const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ));

    await importProjectFromZip(zipPath);

  } else {
    // User canceled the picker
  }
}
