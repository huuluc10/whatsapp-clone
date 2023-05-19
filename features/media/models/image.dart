class Img {
  static final Img _singleton = Img._internal();
  List<String> images = [];

  factory Img() {
    return _singleton;
  }

  Img._internal();

  void addList(String string) {
    images.add(string);
  }
}
