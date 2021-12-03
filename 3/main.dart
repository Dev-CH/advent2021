import '../utils/puzzle_input.dart';
import 'diagnostic.dart';

void main() async {
  final input = PuzzleInput('input.txt').lines as List<String>;
  final dia = Diagnostic(input);

  print(dia.consumption);
  print(dia.lifeSupport);
}
