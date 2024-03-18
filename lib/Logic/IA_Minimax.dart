import 'dart:math';

mixin ia_Minimax {
  List<List<int>> cambinacionesGanadoras = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  bool isMovesLeft(List board) {
    for (int i = 0; i < board.length; i++) {
      if (board[i].label == '') {
        return true;
      }
    }
    return false;
  }

  int minimax(List newBoard, int depth, int alpha, int beta, bool isMaximizingPlayer) {
    int score = checkWin(newBoard);
    if (score == 10) {
      return score;
    }
    if (score == -10) {
      return score;
    }
    if (!isMovesLeft(newBoard)) {
      return 0;
    }

    if (isMaximizingPlayer) {
      int best = -1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i].label == '') {
          newBoard[i].label = 'O';
          best = max(best, minimax(newBoard, depth + 1, alpha, beta, !isMaximizingPlayer));
          newBoard[i].label = '';
          alpha = max(alpha, best);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < newBoard.length; i++) {
        if (newBoard[i].label == '') {
          newBoard[i].label = 'X';
          best = min(best, minimax(newBoard, depth + 1, alpha, beta, !isMaximizingPlayer));
          newBoard[i].label = '';
          beta = min(beta, best);
          if (beta <= alpha) {
            break;
          }
        }
      }
      return best;
    }
  }


  int checkWin(List listButtons) {
    for (List<int> ganador in cambinacionesGanadoras) {
      String primero = listButtons[ganador[0]].label;
      if (primero != '' && primero == listButtons[ganador[1]].label && primero == listButtons[ganador[2]].label) {
        return primero == 'O' ? 10 : -10;
      }
    }
    return 0;
  }
}