import 'dart:io';
import 'package:image/image.dart';
import 'package:path/path.dart' as p;

String convertImage(FileSystemEntity selectedFile, String format) {
  final rawImage = (selectedFile as File).readAsBytesSync();
  final image = decodeImage(rawImage);
  var newImage;

  if (format == 'jpg') {
    newImage = encodeJpg(image!);
  } else if (format == 'png') {
    newImage = encodePng(image!);
  } else {
    print('Sorry, unsupported file type');
  }

  final newPath = replaceExtension(selectedFile.path, format);
  new File(newPath).writeAsBytesSync(newImage);

  return newPath;
}

String replaceExtension(String path, String newExtension) {
  return path.replaceAll(RegExp(r'(png|jpg|jpeg)'), newExtension);
}

bool isSameFormat(FileSystemEntity selectedFile, String format) {
  var extension = p.extension((selectedFile as File).path);
  var normalizeExtension =
      (extension == '.jpg' || extension == '.jpeg') ? 'jpg' : 'png';
  return format == normalizeExtension;
}
