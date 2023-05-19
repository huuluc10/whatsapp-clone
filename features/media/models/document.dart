class Document {
  static final Document _singleton = Document._internal();
  List<String> documents = [];
  List<String> documentsId = [];
  List<String> recieverUsersId = [];

  factory Document() {
    return _singleton;
  }

  Document._internal();

  void addList(String message, String messageId, String recieverUserId) {
    if (!documents.contains(message)) {
      documents.add(message);
      documentsId.add(messageId);
      recieverUsersId.add(recieverUserId);
    }
  }

  void removeList() {
    documents = [];
    documentsId = [];
    recieverUsersId = [];
  }
}
