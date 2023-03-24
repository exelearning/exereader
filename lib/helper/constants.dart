import 'dart:io';

import 'package:flutter/material.dart';

/**
 * Constats used across the code
 */

//List of projects
final List<Widget> projects = [];

//Colors
Color blue = const Color(0xff33bb33);

//List contain Uri to index file
List<String> uris = [];

//List contain ID of project
List<int> ids = [];

//List contain Name of project
List<String> projectsName = [];

//Search
String valueSearch = "";
bool isSearch = false;
List<Widget> projectsSearch = [];

//Contexts
BuildContext? contextHome;

//App Hash
String? appHash;

//Path documentos por defecto
Directory? documentsDirectory;

//Ruta Relativa para pryectos
const String projectsRelativePath = "/projects/";

//Info App
String appVersion = "";
String buildNumber = "";


