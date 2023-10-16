// Developed vy @lucns

// Classe auxiliar para leitura e gravação de arquivos de texto

import 'package:lucns_swapi2/utils/utils.dart';
import 'dart:io';

class Annotator {
  final String defaultFile;
  String? relativePath;

  Annotator(this.relativePath) : defaultFile = "data.txt";

  bool exists() {
    return File("${Utils.DATA_PATH}/${relativePath ?? defaultFile}")
        .existsSync();
  }

  void setRelativePath(String relativePath) {
    this.relativePath = relativePath;
  }

  void delete() {
    File("${Utils.DATA_PATH}/${relativePath ?? defaultFile}").delete();
  }

  void setData(String text) async {
    final File file = File("${Utils.DATA_PATH}/${relativePath ?? defaultFile}");
    await file.writeAsString(text);
  }

  void getData(Function(String content) f) async {
    read().then((value) {
      f(value);
    });
  }

  Future<String> read() async {
    return await File(getPath()).readAsString();
  }

  String getPath() {
    return "${Utils.DATA_PATH}/${relativePath ?? defaultFile}";
  }
}
