class ProjectMetadata {
  String? _title;
  String? _author;
  String? _description;
  String? _license;
  String? _portada;

  ProjectMetadata(String? title, String? author, String? description, String? license, String? portada) {
    _title = title;
    _author = author;
    _description = description;
    _license = license;
    _portada = portada;
  }

  getTitle() {
    return _title;
  }

  getAuthor() {
    return _author;
  }

  getDescription() {
    return _description;
  }

  getLicense() {
    return _license;
  }

  getPortada() {
    return _portada;
  }

}
