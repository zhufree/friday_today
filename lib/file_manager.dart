import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile(filename) async {
  // 获取应用目录
  Directory dir =
  new Directory((await getExternalStorageDirectory()).path + "/Friday");
  if (!await dir.exists()) {
    dir.createSync();
  }
  return new File('${dir.absolute.path}/$filename');
}

Future<File> _getCacheFile() async {
  // 获取应用目录
  Directory dir =
  new Directory((await getTemporaryDirectory()).path + "/Friday");
  if (!await dir.exists()) {
    dir.createSync();
  }
  return new File('${dir.absolute.path}/screenshot_${DateTime.now()}.png');
}