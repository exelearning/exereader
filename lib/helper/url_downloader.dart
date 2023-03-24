import 'dart:core';

const String googleDrive = "Google Drive";
const String dropbox = "Dropbox";
const String ownCloudNextCloud = "OwnCloud/NextCloud";
const String urlDirecta = "URL directa";

enum TiposUrls {
  GoogleDrive(googleDrive),
  Dropbox(dropbox),
  OwnCloudNextCloud(ownCloudNextCloud),
  UrlDirecta(urlDirecta);
  //OneDrive("OneDrive");

  final String valor;

  const TiposUrls(this.valor);
}

class InfoDownloadUrl {
  String _title = "";
  String _url = "";

  InfoDownloadUrl(String title, String url) {
    _title = title;
    _url = url;
  }

  getTitle() {
    return _title;
  }

  getUrl() {
    return _url;
  }
}

String removeUrlParams(String url) {
  if (url.contains("?")) {
    url = url.substring(0, url.indexOf("?"));
  }
  return url;
}

String generateFileName() {
  return "Recurso_${DateTime.now().millisecondsSinceEpoch}.zip";
}

InfoDownloadUrl? getInfoDownloadUrl(String tipo, String url) {
  InfoDownloadUrl? infoDownloadUrl;

  switch (tipo) {
    case urlDirecta:
      if (url.contains(".zip")) {
        url = removeUrlParams(url);
        var filenameArray = url.split("/");
        String filename = filenameArray[filenameArray.length - 1];
        infoDownloadUrl = InfoDownloadUrl(filename, url);
      }

      break;

    case googleDrive:
      if (url.contains("drive.google.com")) {
        url = removeUrlParams(url).trim();
        if(url.startsWith("https://")){
          url = url.replaceFirst("https://", "");
        }
        else if(url.startsWith("http://")){
          url = url.replaceFirst("http://", "");
        }
        var urlSplit = url.split("/");
        String id = urlSplit[3];

        String urlGoogleDrive = "https://drive.google.com/uc?export=download&id=$id";
        String filename = generateFileName();
        infoDownloadUrl = InfoDownloadUrl(filename, urlGoogleDrive);
      }

      break;

    case dropbox:
      if (url.contains("dropbox.com")) {
        url = removeUrlParams(url);
        String urlDropbox = "$url?dl=1";
        String filename = generateFileName();
        infoDownloadUrl = InfoDownloadUrl(filename, urlDropbox);
      }

      break;

    case ownCloudNextCloud:
      if (url.contains("owncloud") || url.contains("nextcloud") || url.contains("cloud.")) {
        url = removeUrlParams(url);
        String urlOwnCloud = url;
        if (!urlOwnCloud.endsWith("/download")) {
          urlOwnCloud = "$urlOwnCloud/download";
        }
        String filename = generateFileName();
        infoDownloadUrl = InfoDownloadUrl(filename, urlOwnCloud);
      }

      break;

    /*case "OneDrive":
      if (url.contains("sharepoint")) {
        url = removeUrlParams(url);
        String urlOneDrive = "$url?download=1";
        String filename = generateFileName();
        infoDownloadUrl = InfoDownloadUrl(filename, urlOneDrive);
      }

      break;*/
    default:
      break;
  }

  return infoDownloadUrl;
}
