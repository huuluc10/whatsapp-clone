class Img {
  static final Img _singleton = Img._internal();
  List<String> images = [];

  List<String> get link => images;

  factory Img() {
    return _singleton;
  }

  Img._internal();

  void addList(String string) {
    if (!images.contains(string)) {
      images.add(string);
    }
  }

  void removeList() {
    images = [];
  }
}
