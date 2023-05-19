class Audio {
  static final Audio _singleton = Audio._internal();
  List<String> audio = [];

  factory Audio() {
    return _singleton;
  }

  Audio._internal();

  void addList(String string) {
    audio.add(string);
  }
}
