// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Do you want to download {filename}?`
  String alertDialogDownloadQuestion(Object filename) {
    return Intl.message(
      'Do you want to download $filename?',
      name: 'alertDialogDownloadQuestion',
      desc: '',
      args: [filename],
    );
  }

  /// `eXeReader`
  String get appTitle {
    return Intl.message(
      'eXeReader',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Project Name`
  String get composeLbSearchHint {
    return Intl.message(
      'Project Name',
      name: 'composeLbSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get composeLbSearchTool {
    return Intl.message(
      'Search',
      name: 'composeLbSearchTool',
      desc: '',
      args: [],
    );
  }

  /// `You can't delete a project when the search mode is on. Please, remove the search criteria before deleting.`
  String get composeMsgDeleteWarning {
    return Intl.message(
      'You can\'t delete a project when the search mode is on. Please, remove the search criteria before deleting.',
      name: 'composeMsgDeleteWarning',
      desc: '',
      args: [],
    );
  }

  /// `Loading page: {url}`
  String debugLoadingPage(Object url) {
    return Intl.message(
      'Loading page: $url',
      name: 'debugLoadingPage',
      desc: '',
      args: [url],
    );
  }

  /// `Downloading {filename}`
  String downloaderDownloading(Object filename) {
    return Intl.message(
      'Downloading $filename',
      name: 'downloaderDownloading',
      desc: '',
      args: [filename],
    );
  }

  /// `Importing project`
  String get downloaderImporting {
    return Intl.message(
      'Importing project',
      name: 'downloaderImporting',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get drawerCredits {
    return Intl.message(
      'Credits',
      name: 'drawerCredits',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get drawerHelp {
    return Intl.message(
      'Help',
      name: 'drawerHelp',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get drawerHome {
    return Intl.message(
      'Home',
      name: 'drawerHome',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get drawerSuggestions {
    return Intl.message(
      'Suggestions',
      name: 'drawerSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `Importing {filename}`
  String floatingImport(Object filename) {
    return Intl.message(
      'Importing $filename',
      name: 'floatingImport',
      desc: '',
      args: [filename],
    );
  }

  /// `CEDEC Resources`
  String get floatingOptionCEDECResources {
    return Intl.message(
      'CEDEC Resources',
      name: 'floatingOptionCEDECResources',
      desc: '',
      args: [],
    );
  }

  /// `Download resource`
  String get floatingOptionDownloadResources {
    return Intl.message(
      'Download resource',
      name: 'floatingOptionDownloadResources',
      desc: '',
      args: [],
    );
  }

  /// `Import resource`
  String get floatingOptionImportResource {
    return Intl.message(
      'Import resource',
      name: 'floatingOptionImportResource',
      desc: '',
      args: [],
    );
  }

  /// `The URL does not contain a valid project`
  String get floatingUrlErrorContent {
    return Intl.message(
      'The URL does not contain a valid project',
      name: 'floatingUrlErrorContent',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get floatingUrlErrorTitle {
    return Intl.message(
      'Error',
      name: 'floatingUrlErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the URL of the resource`
  String get floatingUrlInputTitle {
    return Intl.message(
      'Enter the URL of the resource',
      name: 'floatingUrlInputTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the link type and URL of the resource`
  String get floatingUrl2InputTitle {
    return Intl.message(
      'Enter the link type and URL of the resource',
      name: 'floatingUrl2InputTitle',
      desc: '',
      args: [],
    );
  }

  /// `Author`
  String get genericAuthor {
    return Intl.message(
      'Author',
      name: 'genericAuthor',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get genericBtAccept {
    return Intl.message(
      'Accept',
      name: 'genericBtAccept',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get genericBtCancel {
    return Intl.message(
      'Cancel',
      name: 'genericBtCancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get genericBtDelete {
    return Intl.message(
      'Delete',
      name: 'genericBtDelete',
      desc: '',
      args: [],
    );
  }

  /// `Project deleted`
  String get genericDeletedProject {
    return Intl.message(
      'Project deleted',
      name: 'genericDeletedProject',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get genericDescription {
    return Intl.message(
      'Description',
      name: 'genericDescription',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get genericDetails {
    return Intl.message(
      'Details',
      name: 'genericDetails',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get genericDownload {
    return Intl.message(
      'Download',
      name: 'genericDownload',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get genericLbSearch {
    return Intl.message(
      'Search',
      name: 'genericLbSearch',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get genericLbWarning {
    return Intl.message(
      'Warning',
      name: 'genericLbWarning',
      desc: '',
      args: [],
    );
  }

  /// `Long tap to show description`
  String get genericLongTapToShowDescription {
    return Intl.message(
      'Long tap to show description',
      name: 'genericLongTapToShowDescription',
      desc: '',
      args: [],
    );
  }

  /// `The project was not deleted`
  String get genericNoDeletedProject {
    return Intl.message(
      'The project was not deleted',
      name: 'genericNoDeletedProject',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get genericNotifications {
    return Intl.message(
      'Notifications',
      name: 'genericNotifications',
      desc: '',
      args: [],
    );
  }

  /// `eXeReader is an app for reading contents created with eXeLearning (exelearning.net). \n\n It's a free and open source application, licensed under GPL2+, that allows you to view projects created with eXeLearning and exported as a website (ZIP file).`
  String get helpPart01 {
    return Intl.message(
      'eXeReader is an app for reading contents created with eXeLearning (exelearning.net). \n\n It\'s a free and open source application, licensed under GPL2+, that allows you to view projects created with eXeLearning and exported as a website (ZIP file).',
      name: 'helpPart01',
      desc: '',
      args: [],
    );
  }

  /// `There are different options for uploading a project (ZIP file) to eXeReader: \n\n- "Cedec resources". We can download resources directly from the Cedec website, by selecting the option "Download options" > "Download resource" in the selected resource. \n\n- "Download resource". We can enter a Drive, Dropbox or OneCloud/NextCloud shared link where the ZIP file is hosted or a direct link. \n\n- "Open resource". We can load a project that we have already downloaded on our device.`
  String get helpPart02 {
    return Intl.message(
      'There are different options for uploading a project (ZIP file) to eXeReader: \n\n- "Cedec resources". We can download resources directly from the Cedec website, by selecting the option "Download options" > "Download resource" in the selected resource. \n\n- "Download resource". We can enter a Drive, Dropbox or OneCloud/NextCloud shared link where the ZIP file is hosted or a direct link. \n\n- "Open resource". We can load a project that we have already downloaded on our device.',
      name: 'helpPart02',
      desc: '',
      args: [],
    );
  }

  /// `There are two icons in the top bar. The left one shows the menu and the right one opens the search bar.`
  String get helpPart03 {
    return Intl.message(
      'There are two icons in the top bar. The left one shows the menu and the right one opens the search bar.',
      name: 'helpPart03',
      desc: '',
      args: [],
    );
  }

  /// `The app has several options in the side menu. The first one shows the list of projects. \n\nThe other ones provide information about the application. We encourage you to read it.`
  String get helpPart04 {
    return Intl.message(
      'The app has several options in the side menu. The first one shows the list of projects. \n\nThe other ones provide information about the application. We encourage you to read it.',
      name: 'helpPart04',
      desc: '',
      args: [],
    );
  }

  /// `The project finder allows you to find projects already stored in the application.`
  String get helpPart05 {
    return Intl.message(
      'The project finder allows you to find projects already stored in the application.',
      name: 'helpPart05',
      desc: '',
      args: [],
    );
  }

  /// `To delete a project, slide it to the side.`
  String get helpPart06 {
    return Intl.message(
      'To delete a project, slide it to the side.',
      name: 'helpPart06',
      desc: '',
      args: [],
    );
  }

  /// `To see the description of a project, simply press and hold on the desired project.`
  String get helpPart07 {
    return Intl.message(
      'To see the description of a project, simply press and hold on the desired project.',
      name: 'helpPart07',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this project?`
  String get questionDeleteProject {
    return Intl.message(
      'Do you really want to delete this project?',
      name: 'questionDeleteProject',
      desc: '',
      args: [],
    );
  }

  /// `This resource is already imported`
  String get resourceDuplicate {
    return Intl.message(
      'This resource is already imported',
      name: 'resourceDuplicate',
      desc: '',
      args: [],
    );
  }

  /// `Invalid resource`
  String get resourceNotValid {
    return Intl.message(
      'Invalid resource',
      name: 'resourceNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Upload projects`
  String get titleHelpPart02 {
    return Intl.message(
      'Upload projects',
      name: 'titleHelpPart02',
      desc: '',
      args: [],
    );
  }

  /// `Top bar`
  String get titleHelpPart03 {
    return Intl.message(
      'Top bar',
      name: 'titleHelpPart03',
      desc: '',
      args: [],
    );
  }

  /// `Side menu`
  String get titleHelpPart04 {
    return Intl.message(
      'Side menu',
      name: 'titleHelpPart04',
      desc: '',
      args: [],
    );
  }

  /// `Search bar`
  String get titleHelpPart05 {
    return Intl.message(
      'Search bar',
      name: 'titleHelpPart05',
      desc: '',
      args: [],
    );
  }

  /// `Deleting projects`
  String get titleHelpPart06 {
    return Intl.message(
      'Deleting projects',
      name: 'titleHelpPart06',
      desc: '',
      args: [],
    );
  }

  /// `View description`
  String get titleHelpPart07 {
    return Intl.message(
      'View description',
      name: 'titleHelpPart07',
      desc: '',
      args: [],
    );
  }

  /// `Resource added successfully.\n\nName: `
  String get resourceAdded {
    return Intl.message(
      'Resource added successfully.\n\nName: ',
      name: 'resourceAdded',
      desc: '',
      args: [],
    );
  }

  /// `No projects have been found with the search criteria applied`
  String get resourceNoFound {
    return Intl.message(
      'No projects have been found with the search criteria applied',
      name: 'resourceNoFound',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while downloading the resource`
  String get errorDownloadResource {
    return Intl.message(
      'An error occurred while downloading the resource',
      name: 'errorDownloadResource',
      desc: '',
      args: [],
    );
  }

  /// `Loading resources...`
  String get loadingResources {
    return Intl.message(
      'Loading resources...',
      name: 'loadingResources',
      desc: '',
      args: [],
    );
  }

  /// `The resource is not valid. It must be a file with a .zip extension`
  String get resourceNotValidZipExtension {
    return Intl.message(
      'The resource is not valid. It must be a file with a .zip extension',
      name: 'resourceNotValidZipExtension',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Contact from App eXeReader`
  String get subjectEmail {
    return Intl.message(
      'Contact from App eXeReader',
      name: 'subjectEmail',
      desc: '',
      args: [],
    );
  }

  /// `Failed to import resource`
  String get errorImportProject {
    return Intl.message(
      'Failed to import resource',
      name: 'errorImportProject',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
