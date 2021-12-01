import 'dart:io';

Future<int> getWindowSteps() async {
  final List<String> input = await File('input.txt').readAsLines();

  int increased = 0;
  int previous = int.parse(input[0]);
  List<int> window = [];

  for (var i = 0; i < input.length; i++) {
    final currentCoord = int.parse(input[i]);
    if (window.length < 3) {
      window.add(currentCoord);
      continue;
    }

    window.removeAt(0);
    window.add(currentCoord);

    var windowSum = window.reduce((a, b) => a + b);
    if (windowSum > previous) {
      increased++;
    }

    previous = windowSum;
  }
  return increased;
}

void main(List<String> args) async {
  print(await getWindowSteps());
}
