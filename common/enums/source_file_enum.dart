enum SourceFile {
  gallary('gallary'),
  camera('camera');

  const SourceFile(this.type);
  final String type;
}

extension ConvertSource on String {
  SourceFile toEnum() {
    switch (this) {
      case 'gallary':
        return SourceFile.gallary;
      default:
        return SourceFile.camera;
    }
  }
}
