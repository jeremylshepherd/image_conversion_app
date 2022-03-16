import 'dart:io';

import 'package:prompter_jeremylshepherd/prompter_jeremylshepherd.dart';

void main() {
  var prompter = Prompter();

  final input = prompter.askBinary("Do you wish to convert an image?");
  if (!input) {
    exit(0);
  }

  List<Option> _buildFormatOptions() {
    return [
      Option('Convert to jpeg', 'jpeg'),
      Option('Convert to png', 'png'),
    ];
  }

  final format = prompter.askMultiple("Select format: ", _buildFormatOptions());

  List<Option> _buildFileOptions() {
    final entities =
        Directory.current.listSync(recursive: true).where((entity) {
      return FileSystemEntity.isFileSync(entity.path) &&
          entity.path.contains(RegExp(r'\.(png|jpg|jpeg)'));
    }).map((e) {
      final filename = e.path.split(Platform.pathSeparator).last;
      return Option(
        filename,
        e,
      );
    }).toList();

    print(entities);
    return entities;
  }

  final path =
      prompter.askMultiple("Select an image to convert", _buildFileOptions());

  //Look through that and find only the images

  // Take all the images and create an Option object from all the images
}
