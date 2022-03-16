import 'dart:io';
import 'package:image_coversion_app/src/converter.dart';
import 'package:prompter_jeremylshepherd/prompter_jeremylshepherd.dart';

void main() {
  var prompter = Prompter();

  final input = prompter.askBinary("Do you wish to convert an image?");
  if (!input) {
    print('Okay, have a nice day! 😎');
    exit(0);
  }

  List<Option> _buildFormatOptions() {
    return [
      Option('Convert to jpeg', 'jpg'),
      Option('Convert to png', 'png'),
    ];
  }

  final format = prompter.askMultiple("Select format: ", _buildFormatOptions());

  List<Option> _buildFileOptions() {
    final entities = Directory.current
        .listSync(recursive: true)
        .where((entity) =>
            FileSystemEntity.isFileSync(entity.path) &&
            entity.path.contains(RegExp(r'\.(png|jpg|jpeg)')))
        .map((e) {
      final filename = e.path.split(Platform.pathSeparator).last;
      return Option(
        filename,
        e,
      );
    }).toList();
    return entities;
  }

  final selectedImage =
      prompter.askMultiple("Select an image to convert", _buildFileOptions());

  if (isSameFormat(selectedImage, format)) {
    print('$selectedImage is already in $format format, so piece of 🍰.');
    exit(0);
  }

  final newPath = convertImage(selectedImage, format);
  final shouldOpen = prompter.askBinary('Open the new image at [ $newPath ]?');

  if (shouldOpen) {
    Process.run('start', [newPath], runInShell: true);
  }
}
