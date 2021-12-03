import 'dart:io';

void main() async {
  final List<String> input = await File('input.txt').readAsLines();

  int depth = 0;
  int horizontal = 0;
  int aim = 0;

  for (var i = 0; i < input.length; i++) {
    final List<String> instruction = input[i].split(' ');
    final String action = instruction[0];
    final int distance = int.parse(instruction[1]);

    if (action == 'forward') {
      horizontal = horizontal + distance;
      depth = depth + (distance * aim);
    } else {
      aim = (action == 'up') ? aim - distance : aim + distance;
    }
  }

  print(horizontal * depth);
}
