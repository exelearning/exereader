// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(filename) => "Do you want to download ${filename}?";

  static String m1(url) => "Loading page: ${url}";

  static String m2(filename) => "Downloading ${filename}";

  static String m3(filename) => "Importing ${filename}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alertDialogDownloadQuestion": m0,
        "appTitle": MessageLookupByLibrary.simpleMessage("eXeReader"),
        "composeLbSearchHint":
            MessageLookupByLibrary.simpleMessage("Project Name"),
        "composeLbSearchTool": MessageLookupByLibrary.simpleMessage("Search"),
        "composeMsgDeleteWarning": MessageLookupByLibrary.simpleMessage(
            "You can\'t delete a project when the search mode is on. Please, remove the search criteria before deleting."),
        "debugLoadingPage": m1,
        "downloaderDownloading": m2,
        "downloaderImporting":
            MessageLookupByLibrary.simpleMessage("Importing project"),
        "drawerCredits": MessageLookupByLibrary.simpleMessage("Credits"),
        "drawerHelp": MessageLookupByLibrary.simpleMessage("Help"),
        "drawerHome": MessageLookupByLibrary.simpleMessage("Home"),
        "drawerSuggestions":
            MessageLookupByLibrary.simpleMessage("Suggestions"),
        "errorDownloadResource": MessageLookupByLibrary.simpleMessage(
            "Could not download the resource. Access might be restricted."),
        "errorImportProject":
            MessageLookupByLibrary.simpleMessage("Failed to import resource"),
        "floatingImport": m3,
        "floatingOptionCEDECResources":
            MessageLookupByLibrary.simpleMessage("CEDEC Resources"),
        "floatingOptionDownloadResources":
            MessageLookupByLibrary.simpleMessage("Download resource"),
        "floatingOptionImportResource":
            MessageLookupByLibrary.simpleMessage("Open resource"),
        "floatingUrl2InputTitle": MessageLookupByLibrary.simpleMessage(
            "Enter the link type and URL of the resource"),
        "floatingUrlErrorContent": MessageLookupByLibrary.simpleMessage(
            "The URL does not contain a valid project"),
        "floatingUrlErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
        "floatingUrlInputTitle": MessageLookupByLibrary.simpleMessage(
            "Enter the URL of the resource"),
        "genericAuthor": MessageLookupByLibrary.simpleMessage("Author"),
        "genericBtAccept": MessageLookupByLibrary.simpleMessage("Accept"),
        "genericBtCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "genericBtDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "genericDeletedProject":
            MessageLookupByLibrary.simpleMessage("Project deleted"),
        "genericDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "genericDetails": MessageLookupByLibrary.simpleMessage("Details"),
        "genericDownload": MessageLookupByLibrary.simpleMessage("Download"),
        "genericLbSearch": MessageLookupByLibrary.simpleMessage("Search"),
        "genericLbWarning": MessageLookupByLibrary.simpleMessage("Warning"),
        "genericLongTapToShowDescription": MessageLookupByLibrary.simpleMessage(
            "Long tap to show description"),
        "genericNoDeletedProject":
            MessageLookupByLibrary.simpleMessage("The project was not deleted"),
        "genericNotifications":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "helpPart01": MessageLookupByLibrary.simpleMessage(
            "eXeReader is an app for reading contents created with eXeLearning (exelearning.net). \n\n It\'s a free and open source application, licensed under GPL2+, that allows you to view projects created with eXeLearning and exported as a website (ZIP file)."),
        "helpPart02": MessageLookupByLibrary.simpleMessage(
            "There are different options for uploading a project (ZIP file) to eXeReader: \n\n- \"Cedec resources\". We can download resources directly from the Cedec website, by selecting the option \"Download options\" > \"Download resource\" in the selected resource. \n\n- \"Download resource\". We can enter a Drive, Dropbox or OneCloud/NextCloud shared link where the ZIP file is hosted or a direct link. \n\n- \"Import resource\". We can load a project that we have already downloaded on our device."),
        "helpPart03": MessageLookupByLibrary.simpleMessage(
            "There are two icons in the top bar. The left one shows the menu and the right one opens the search bar."),
        "helpPart04": MessageLookupByLibrary.simpleMessage(
            "The app has several options in the side menu. The first one shows the list of projects. \n\nThe other ones provide information about the application. We encourage you to read it."),
        "helpPart05": MessageLookupByLibrary.simpleMessage(
            "The project finder allows you to find projects already stored in the application."),
        "helpPart06": MessageLookupByLibrary.simpleMessage(
            "To delete a project, slide it to the side."),
        "helpPart07": MessageLookupByLibrary.simpleMessage(
            "To see the description of a project, simply press and hold on the desired project."),
        "license": MessageLookupByLibrary.simpleMessage("License"),
        "loadingResources":
            MessageLookupByLibrary.simpleMessage("Loading resources..."),
        "questionDeleteProject": MessageLookupByLibrary.simpleMessage(
            "Do you really want to delete this project?"),
        "resourceAdded": MessageLookupByLibrary.simpleMessage(
            "Resource added successfully.\n\nName: "),
        "resourceDuplicate": MessageLookupByLibrary.simpleMessage(
            "This resource is already imported"),
        "resourceNoFound": MessageLookupByLibrary.simpleMessage(
            "No projects have been found with the search criteria applied"),
        "resourceNotValid":
            MessageLookupByLibrary.simpleMessage("Invalid resource. Maybe the zip file was not created with eXeLearning."),
        "resourceNotValidZipExtension": MessageLookupByLibrary.simpleMessage(
            "The resource is not valid. It must be a file with a .zip extension"),
        "subjectEmail":
            MessageLookupByLibrary.simpleMessage("Contact from App eXeReader"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "titleHelpPart02":
            MessageLookupByLibrary.simpleMessage("Upload projects"),
        "titleHelpPart03": MessageLookupByLibrary.simpleMessage("Top bar"),
        "titleHelpPart04": MessageLookupByLibrary.simpleMessage("Side menu"),
        "titleHelpPart05": MessageLookupByLibrary.simpleMessage("Search bar"),
        "titleHelpPart06":
            MessageLookupByLibrary.simpleMessage("Deleting projects"),
        "titleHelpPart07":
            MessageLookupByLibrary.simpleMessage("View description")
      };
}
