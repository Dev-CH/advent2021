import 'dart:io';

class PuzzleInput {
  final String path;
  List<dynamic> lines = [];

  PuzzleInput(this.path) {
    lines = _fileLines;
  }

  PuzzleInput.asInt(this.path) {
    lines = _fileLines.map((line) => int.parse(line)).toList();
  }
  
  List<String> get _fileLines => File(this.path).readAsLinesSync();
}
