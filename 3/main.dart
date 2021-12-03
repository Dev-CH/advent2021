import '../utils/puzzle_input.dart';
import 'diagnostic.dart';

void main() async {
  final input = PuzzleInput('example.txt').lines as List<String>;
  final dia = Diagnostic(input);

  print(dia.consumption);
}
