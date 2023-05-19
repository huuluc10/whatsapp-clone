class Document {
  static final Document _singleton = Document._internal();
  List<String> document = [];

  factory Document() {
    return _singleton;
  }

  Document._internal();

  void addList(String string) {
    document.add(string);
  }
}
