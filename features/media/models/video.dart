class Video {
  static final Video _singleton = Video._internal();
  List<String> videos = [];

  factory Video() {
    return _singleton;
  }

  Video._internal();

  void addList(String string) {
    if (!videos.contains(string)) {
      videos.add(string);
    }
  }

  void removeList() {
    videos = [];
  }
}
