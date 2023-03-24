import 'dart:io';
import 'dart:typed_data';
import 'package:exereader/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/text.dart' as Text;
import 'package:http/http.dart' as http;

import 'package:exereader/helper/constants.dart';

import '../generated/l10n.dart';

showDialogErrorDownloadResource() {
  BuildContext context = contextHome!;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: const Text.Text("Error"),
            content: Text.Text(S.of(context).errorDownloadResource),
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

// This method allows handling as an asynchronous operation
// the download request by the user
downloadFile(String url, String filename, notifyParent) async {
  var httpClient = http.Client();
  var request = http.Request('GET', Uri.parse(url));
  //var response = httpClient.send(request);
  String dir = (await getApplicationDocumentsDirectory()).path;

  List<List<int>> chunks = [];
  int downloaded = 0;

  double _progressValue = 0;

  BuildContext context = contextHome!;

  bool isDownloadComplete = false;

  StateSetter? setStateDialog;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            title: Text.Text(S.of(context).downloaderDownloading(filename)),
            content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              setStateDialog = setState;
              return SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  value: _progressValue,
                ),
                Text.Text(
                  "\n" + ((isDownloadComplete) ? S.of(context).downloaderImporting : "${(_progressValue * 100).round()}%"),
                  textAlign: TextAlign.center,
                )
              ]));
            }));
      });

  httpClient.send(request).asStream().listen((http.StreamedResponse r) async {
    if (r.statusCode == HttpStatus.notFound) {
      Navigator.of(context).pop();
      showDialogErrorDownloadResource();
      return;
    }

    r.stream.listen((List<int> chunk) {
      // Display percentage of completion
      //print('downloadPercentage: ${downloaded / r.contentLength! * 100}');

      //Notify to dialog download percentage
      setStateDialog!(() {
        _progressValue = downloaded / r.contentLength!;
      });
      chunks.add(chunk);
      downloaded += chunk.length;
    }, onDone: () async {
      // Display percentage of completion
      //print('downloadPercentage: ${downloaded / r.contentLength! * 100}');

      // Notify to dialog download complete
      setStateDialog!(() {
        isDownloadComplete = true;
      });

      File? result = null;

      if (r.statusCode != HttpStatus.ok) {
        //print(r.toString());
      } else {
        try {
          if (filename.startsWith("Recurso_") && r.headers.containsKey("content-disposition")) {
            String contentDisposition = r.headers["content-disposition"].toString();
            //attachment; filename=\"TestTD.zip\"; filename*=UTF-8''TestTD.zip
            if (contentDisposition.isNotEmpty && contentDisposition.contains("filename=")) {
              int indexStartFileName = contentDisposition.indexOf("filename=") + "filename=".length + 1;
              int indexEndFileName = contentDisposition.indexOf("\"", indexStartFileName);
              filename = contentDisposition.substring(indexStartFileName, indexEndFileName);
            }
          }

          // Save the file unzipped
          File file = File('$dir/$filename');
          final Uint8List bytes = Uint8List(r.contentLength!);
          int offset = 0;
          for (List<int> chunk in chunks) {
            bytes.setRange(offset, offset + chunk.length, chunk);
            offset += chunk.length;
          }
          result = await file.writeAsBytes(bytes, flush: true);

          final zipPath = result.path.toString();
          await importProjectFromZip(zipPath);

        } catch (e) {
          Navigator.of(context).pop();
          showDialogErrorDownloadResource();
        }
      }
    }, onError: (Object error) {
      Navigator.of(context).pop();
      showDialogErrorDownloadResource();
    });
  });
}
