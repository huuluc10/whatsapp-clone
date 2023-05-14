enum TypeFile {
  doc('doc'),
  docx('docx'),
  xml('xml'),
  rar('rar'),
  zip('zip'),
  pdf('pdf'),
  txt('txt'),
  sql('sql'),
  c('c'),
  cpp('cpp'),
  xsl('xsl'),
  xlsx('xlsx'),
  pptx('pptx'),
  dart('dart'),
  apk('apk'),
  html('html'),
  js('js'),
  css('css'),
  java('java');

  const TypeFile(this.type);
  final String type;
}

extension ConvertSource on String {
  TypeFile toEnum() {
    switch (this) {
      case 'doc':
        return TypeFile.doc;
      case 'docx':
        return TypeFile.docx;
      case 'xml':
        return TypeFile.xml;
      case 'rar':
        return TypeFile.rar;
      case 'zip':
        return TypeFile.zip;
      case 'pdf':
        return TypeFile.pdf;
      case 'txt':
        return TypeFile.txt;
      case 'sql':
        return TypeFile.sql;
      case 'c':
        return TypeFile.c;
      case 'cpp':
        return TypeFile.cpp;
      case 'xsl':
        return TypeFile.xsl;
      case 'pptx':
        return TypeFile.pptx;
      case 'dart':
        return TypeFile.dart;
      case 'apk':
        return TypeFile.apk;
      case 'html':
        return TypeFile.html;
      case 'js':
        return TypeFile.js;
      case 'css':
        return TypeFile.css;
      default:
        return TypeFile.java;
    }
  }
}
