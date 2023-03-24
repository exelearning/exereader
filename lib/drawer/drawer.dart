import 'package:exereader/compose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:exereader/generated/l10n.dart';
import 'package:exereader/help/help_page.dart';
import 'package:exereader/helper/route_animaton.dart';
import 'package:exereader/pages/web_view.dart';

import '../helper/constants.dart';

/**
 * Widget that controls the side menu of the application, it is visible
 * throughout the cycle of use by the user
 */

class DrawerNav extends StatefulWidget {
  const DrawerNav({Key? key}) : super(key: key);

  @override
  DrawerNavState createState() => DrawerNavState();
}

class DrawerNavState extends State<DrawerNav> {
  @override
  Widget build(BuildContext context) {
    //String versionInfo = "$appVersion ($buildNumber)";
    String versionInfo = "v.$appVersion";

    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: ListView(
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text("\n"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage('assets/ico_drawer.png'),
                      alignment: Alignment.center,
                    )
                  ],
                )
              ],
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
          const Text(
            "\neXeReader",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Divider(
            color: (MediaQuery.of(context).platformBrightness == Brightness.dark) ? Colors.white : Colors.black45,
            height: 45,
          ),
          ListTile(
            title: const Text("Inicio", textAlign: TextAlign.justify),
            leading: const Icon(Icons.home),
            onTap: () async {
              //Navigator.of(context).popUntil((route) => route.isFirst);
              await Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ExeReaderBodyApp()),
                (route) => false, //route.isFirst or false
              );
              if (Navigator.canPop(context)) {
                Navigator.pop(context); //close drawer
              }
            },
          ),
          ListTile(
            title: Text(S.of(context).drawerHelp, textAlign: TextAlign.justify),
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.of(context).push(Transition(pagina: HelpPage()));
            },
          ),
          ListTile(
            title: Text(S.of(context).drawerSuggestions, textAlign: TextAlign.justify),
            leading: const Icon(Icons.pending_actions),
            onTap: () {
              if (Localizations.localeOf(context).languageCode == "es") {
                if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
                  Navigator.of(context).push(
                      Transition(pagina: WebViewWidget(url: 'assets/suggestions/suggestions_es_dark.html', title: S.of(context).drawerSuggestions)));
                } else {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/suggestions/suggestions_es.html', title: S.of(context).drawerSuggestions)));
                }
              } else {
                if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
                  Navigator.of(context).push(
                      Transition(pagina: WebViewWidget(url: 'assets/suggestions/suggestions_en_dark.html', title: S.of(context).drawerSuggestions)));
                } else {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/suggestions/suggestions_en.html', title: S.of(context).drawerSuggestions)));
                }
              }
            },
          ),
          ListTile(
            title: Text(S.of(context).drawerCredits, textAlign: TextAlign.justify),
            leading: const Icon(Icons.person),
            onTap: () {
              //Detect dark mode and language
              if (Localizations.localeOf(context).languageCode == "es") {
                if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/credits/credits_es_dark.html', title: S.of(context).drawerCredits)));
                } else {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/credits/credits_es.html', title: S.of(context).drawerCredits)));
                }
              } else {
                if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/credits/credits_en_dark.html', title: S.of(context).drawerCredits)));
                } else {
                  Navigator.of(context)
                      .push(Transition(pagina: WebViewWidget(url: 'assets/credits/credits_en.html', title: S.of(context).drawerCredits)));
                }
              }
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                title: Text(versionInfo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
