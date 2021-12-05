import 'dart:io';

typedef BingoBoard = List<Map<dynamic, bool>>;

class BingoInput {
  final String path;
  List<dynamic> boards = [];
  List<int> input = [];
  BingoBoard? winner = null;

  BingoInput(this.path) {
    final allLines = _fileLines; 
    final firstLine = allLines.first.split(',');
    input = firstLine.map((v) => int.parse(v)).toList();
    allLines.removeAt(0);

    BingoBoard temp = [];
    final first = allLines.forEach((line) {
      if (line != '') {
        final split = line.split(' ')..removeWhere((item) => item == '');
        final row = Map.fromIterable(split.map((item) => int.parse(item)), key: (i) => i, value: (v) => false);
        temp.add(row);
      }

      if (temp.length == 5) {
        boards.add(temp);
        temp = [];
      }
    });
  }

  void play() {
    int i = -1;
    while(winner == null) {
      i++;
      takeTurn(i);
    }

    draw(winner!);

    num total = 0;
    winner!.forEach((row) {
      row.forEach((key, selected) {
        if (!selected) {
          total = total + key;
        }
      });
    });

    print(total * input[i]);
  }

  void takeTurn(int turn) {
    bool lookingForFirst = false; // remove bool here if looking for winning board.

    final selected = input[turn];
    boards.forEach((board) {
      _checkBoard(board, selected);
    });

    _checkWinner(lookingForFirst);
  }

  void output() {
    for (var i = 0; i < boards.length; i++) {
      draw(boards[i]);
    }
  }

  void draw(BingoBoard board) {
    print(' ');
    board.forEach((row) {      
      _print_row(row);
    });
  }

  void _checkBoard(BingoBoard board, value) {
    board.forEach((row) {
      if (row.containsKey(value)) {        
        row[value] = true;
      }
    });
  }

  void _checkWinner([bool first = true]) {
    if (!first && boards.length == 1) {
      winner = boards[0];
      return;
    }

    final bingoBoards = boards;
    for (var boardIndex = 0; boardIndex < bingoBoards.length; boardIndex++) {
      final board = bingoBoards[boardIndex];

      BingoBoard? winningBoard = _checkRow(board);

      if (winningBoard == null) {
        winningBoard = _checkColumn(board);
      }

      if (winningBoard != null) {
        if (first) {
          winner = winningBoard;
        } else {
          boards.removeAt(boardIndex);
        }
      }
    }
  }

  BingoBoard? _checkRow(BingoBoard board) {
    for (var rowIndex = 0; rowIndex < board.length ; rowIndex++) {
      final row = board[rowIndex];
      if (row.values.where((v) => v == true).length == 5) {
        return board;
      }
    }

    return null;
  }

  BingoBoard? _checkColumn(BingoBoard board) {
    int row = 0;
    for (var column = 0; column < board.length; column++) {
      bool hasColumn = true;
      for (var row = 0; row < board.length; row++) {
        if (board[row].values.toList()[column] == false) {
          hasColumn = false;
          break;
        }
      }

      if (hasColumn) {
        return board;
      }
    }

    return null;
  }

  void _print_row(row) {
    String line = '';

    row.forEach((key, state) {
      line += (state) ? '\x1B[32m${_printKey(key)}\x1B[0m ' : '\x1B[31m${_printKey(key)}\x1B[0m ' ;
    });

    print(line);
  }

  String _printKey(int key) {
    if (key < 10) {
      return ' $key';
    }

    return key.toString();
  }

  List<String> get _fileLines => File(this.path).readAsLinesSync();
}
