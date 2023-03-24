import 'dart:io' show File, Platform, stderr, stdout;
import 'package:exereader/helper/downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart' as web_view_plus;
import '../Drawer/drawer.dart';
import '../generated/l10n.dart';

/**
 * This widget is the webview that is used to display the eXeLearning applications
 * imported by the user, it is only visible when the user selects an application.
 */

class WebViewWidget extends StatefulWidget {
  //Constant for url to project's index.html
  final String url;
  final String title;

  const WebViewWidget({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  //Initialize WebView with project's index.html
  @override
  void initState() {
    super.initState();

    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    //print("Loading page: ${widget.url}"); //For follow stack trace
  }

  late web_view_plus.WebViewPlusController _webViewController;

  bool canGoBack = false;
  bool canGoForward = false;
  int indexPosition = 1;
  bool firstLoad = true;
  bool webResourceError = false;

  @override
  Widget build(BuildContext context) {
    /*print("###### build WebViewWidget");
    print("###### indexPosition: " + indexPosition.toString());
    print("###### webResourceError: " + webResourceError.toString());
    print("###### canGoBack: " + canGoBack.toString());
    print("###### canGoForward: " + canGoForward.toString());*/

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Icon iconNavigationBack = Icon(Icons.arrow_back_ios, color: (!canGoBack) ? Colors.black12 : Colors.white, size: 22.0);
    Icon iconNavigationForward = Icon(Icons.arrow_forward_ios, color: (!canGoForward) ? Colors.black12 : Colors.white, size: 22.0);

    // List of navigation buttons
    List<Widget> navigationButtons = [
      IconButton(
          padding: const EdgeInsets.fromLTRB(8, 0, 25, 0),
          onPressed: (!canGoBack)
              ? null
              : () async {
                  /*bool canGoBack = await _webViewController.webViewController.canGoBack();
            if (canGoBack) _webViewController.webViewController.goBack();*/
                  _webViewController.webViewController.goBack();
                },
          icon: iconNavigationBack),
      IconButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
          onPressed: (!canGoForward)
              ? null
              : () async {
                  /*bool canGoForward = await _webViewController.webViewController.canGoForward();
            if (canGoForward) _webViewController.webViewController.goForward();*/
                  _webViewController.webViewController.goForward();
                },
          icon: iconNavigationForward)
    ];

    bool isFile = (Platform.isAndroid) ? widget.url.startsWith("/data/") : widget.url.contains("/Data/");

    return Scaffold(
      backgroundColor: (isDark) ? const Color(0xFF2E2E2E) : Colors.white,
      appBar: AppBar(
          title: (widget.title.isNotEmpty) ? Text(widget.title) : Text(S.of(context).appTitle),
          titleTextStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 19),
          titleSpacing: 0,
          centerTitle: false,
          backgroundColor: Colors.green,
          actions: navigationButtons,
          leading: IconButton(
              onPressed: () async {
                await Navigator.maybePop(context);
              },
              icon: const Icon(Icons.arrow_back, size: 26))),
      drawer: const DrawerNav(),
      body: IndexedStack(
        index: indexPosition,
        children: <Widget>[
          web_view_plus.WebViewPlus(
            initialUrl: (isFile) ? "" : widget.url,
            onWebViewCreated: (controller) {
              // Extract to webView controller for adds controllers to go or to
              // back a the previous page
              _webViewController = controller;
              if (isFile) {
                _webViewController.webViewController.loadFile(widget.url);
              }
            },
            navigationDelegate: (request) {
              return handleDownloadRequest(request, context);
            },
            onPageStarted: (url) {
              //print("######onPageStarted: $url");
              webResourceError = false;
              if (!url.contains("localhost") && Platform.isAndroid) {
                int newIndexPosition = (firstLoad) ? 1 : 0;
                refreshWebViewState(newIndexPosition);
              }
              firstLoad = false;
            },
            onPageFinished: (finish) {
              //print("######onPageFinished");
              if (indexPosition == 1 || webResourceError || Platform.isIOS) {
                refreshWebViewState(0);
              }
            },
            onWebResourceError: (error) {
              //print("######onWebResourceError");
              webResourceError = true;
              /*setState(() {
                indexPosition = 0;
              });*/
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(0, 60.0, 0, 0),
              color: (isDark) ? const Color(0xFF2E2E2E) : Colors.white,
              child: const CircularProgressIndicator())
        ],
      ),
    );
  }

  void refreshWebViewState(int indexP) async {
    bool canBack = await _webViewController.webViewController.canGoBack();
    bool canForward = await _webViewController.webViewController.canGoForward();
    setState(() {
      indexPosition = indexP;
      canGoBack = canBack;
      canGoForward = canForward;
    });
  }

  // This method handle download request, filter this request for only contains
  // file with extensions ".zip" and send request to asynchronous method
  // for download files
  NavigationDecision handleDownloadRequest(web_view_plus.NavigationRequest request, BuildContext context) {
    if (request.url.contains(".zip")) {
      var arrayUrl = request.url.split("/");
      var filename = arrayUrl[arrayUrl.length - 1];
      showDialog(context: context, builder: (_) => showConfirmDownloadDialog(context, filename, request));
      return NavigationDecision.prevent;
    } else if (request.url.contains("mailto:")) {
      String mailTo = request.url.split(":")[1].trim();
      sendEmail(mailTo);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  void sendEmail(String emailAddress) async {
    final Email email = Email(
        body: '',
        subject: S.of(context).subjectEmail,
        recipients: [emailAddress],
        //cc: ['cc@example.com'],
        //bcc: ['bcc@example.com'],
        //attachmentPaths: ['/path/to/attachment.zip'],
        isHTML: false);
    await FlutterEmailSender.send(email);
  }

  // This method return an AlertDialog contains the question of
  // confirmation of Download
  AlertDialog showConfirmDownloadDialog(BuildContext context, String filename, web_view_plus.NavigationRequest request) {
    return AlertDialog(
      title: Text(S.of(context).genericDownload),
      content: Text(S.of(context).alertDialogDownloadQuestion(filename)),
      actions: <Widget>[
        MaterialButton(
            onPressed: () {
              refresh() {
                setState() {}
              }
              Navigator.of(context).pop(); //close dialog
              downloadFile(request.url, filename, refresh());
            },
            textColor: Colors.green,
            child: Text(S.of(context).genericBtAccept)),
        MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.red,
            child: Text(S.of(context).genericBtCancel))
      ],
    );
  }
}
