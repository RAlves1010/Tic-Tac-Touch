import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_touch/src/constants/colors.dart' as colors;
import 'package:tic_tac_touch/src/screens/home_screen.dart';
import 'package:tic_tac_touch/src/widgets/custom_elevated_button.dart';
import 'package:tic_tac_touch/src/widgets/custom_text.dart';

class PlayScreen extends StatefulWidget {
  final bool computerPlaying;
  final String difficulty;

  const PlayScreen({
    super.key,
    required this.computerPlaying,
    required this.difficulty
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<String> board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
  Map<String, int> scores = {'X': -1, 'O': 1, 'DRAW': 0};
  bool playing = true;
  bool xTurn = true;
  bool computerTurn = false;

  void endGame(bool stopGame) {
    if (stopGame) {
      playing = false;
    }
  }

  String winner(int index) {
    if (board[index] == 'X') {
      return 'X';
    } else {
      return 'O';
    }
  }

  String checkDraw(bool stopGame) {
    bool boardFull = true;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == ' ') {
        boardFull = false;
      }
    }

    if (boardFull) {
      if (stopGame) {
        playing = false;
      }
      return 'DRAW';
    } else {
      return ' ';
    }
  }

  String checkWinner(bool stopGame) {
    if (board[0] == board[1] && board[1] == board[2] && board[2] != ' ') {
      endGame(stopGame);
      return winner(0);
    }

    if (board[3] == board[4] && board[4] == board[5] && board[5] != ' ') {
      endGame(stopGame);
      return winner(3);
    }

    if (board[6] == board[7] && board[7] == board[8] && board[8] != ' ') {
      endGame(stopGame);
      return winner(6);
    }

    if (board[0] == board[3] && board[3] == board[6] && board[6] != ' ') {
      endGame(stopGame);
      return winner(0);
    }

    if (board[1] == board[4] && board[4] == board[7] && board[7] != ' ') {
      endGame(stopGame);
      return winner(1);
    }

    if (board[2] == board[5] && board[5] == board[8] && board[8] != ' ') {
      endGame(stopGame);
      return winner(2);
    }

    if (board[0] == board[4] && board[4] == board[8] && board[8] != ' ') {
      endGame(stopGame);
      return winner(0);
    }

    if (board[2] == board[4] && board[4] == board[6] && board[6] != ' ') {
      endGame(stopGame);
      return winner(2);
    }

    return checkDraw(stopGame);
  }

  Widget winnerInfo(String winner,  double screenHeight) {
    String player = widget.computerPlaying ? 'YOU' : 'X';
    String opponent = widget.computerPlaying ? 'COMPUTER' : 'O';
    String verbWin = player == 'YOU' ? 'WIN' : 'WINS';

    if (winner == 'X') {
      return CustomText(text: '$player $verbWin!', color: colors.blue, fontSize: screenHeight * 0.068);
    }

    if (winner == 'O') {
      return CustomText(text: '$opponent WINS!', color: colors.red, fontSize: screenHeight * 0.068);
    }

    return CustomText(text: 'DRAW!', color: colors.white, fontSize: screenHeight * 0.068);
  }

  Widget gameInfo(double screenHeight) {
    String player = widget.computerPlaying ? 'YOUR' : 'X\'S';
    String opponent = widget.computerPlaying ? 'COMPUTER\'S' : 'O\'S';

    if (playing && xTurn) {
      return CustomText(
        text: '$player TURN',
        color: colors.blue,
        fontSize: screenHeight * 0.068
      );
    }

    if (playing && !xTurn) {
      return CustomText(
        text: '$opponent TURN',
        color: colors.red,
        fontSize: screenHeight * 0.068
      );
    }

    return winnerInfo(checkWinner(true), screenHeight);
  }

  void tap(String symbol, int index) {
    if (board[index] == ' ') {
      board[index] = symbol;
      xTurn = !xTurn;
    }
  }

  void play(int index) {
    if (playing) {
      if (widget.computerPlaying) {
        if (xTurn) {
          tap('X', index);
        }
      } else {
        if (xTurn) {
          tap('X', index);
        } else {
          tap('O', index);
        }
      }
    }
  }

  int randomPlay() {
    int random;

    do {
      random = Random().nextInt(board.length);
    } while (board[random] != ' ');

    return random;
  }

  int minimax(List<String> gameBoard, int depth, bool isMaximizing, bool mediumDifficulty) {
    String result = checkWinner(false);
    if (result != ' ') {
      return scores[result]!;
    }

    if (isMaximizing) {
      int bestScore = -2;
      for (int i = 0; i < gameBoard.length; i++) {
        if (gameBoard[i] == ' ') {
          gameBoard[i] = 'O';
          int score = minimax(gameBoard, depth + 1, mediumDifficulty, mediumDifficulty);
          gameBoard[i] = ' ';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 2;
      for (int i = 0; i < gameBoard.length; i++) {
        if (gameBoard[i] == ' ') {
          gameBoard[i] = 'X';
          int score = minimax(gameBoard, depth + 1, true, mediumDifficulty);
          gameBoard[i] = ' ';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  int nextPlay(bool mediumDifficulty) {
    int bestScore = -2;
    int bestPossiblePlay = -1;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == ' ') {
        board[i] = 'O';
        int score = minimax(board, 0, false, mediumDifficulty);
        board[i] = ' ';
        if (score > bestScore) {
          bestScore = score;
          bestPossiblePlay = i;
        }
      }
    }
    return bestPossiblePlay;
  }
  
  void computerPlay() {
    if (playing && !xTurn) {
      if (widget.difficulty == 'EASY') {
        tap('O', randomPlay());
      }

      if (widget.difficulty == 'MEDIUM') {
        tap('O', nextPlay(true));
      }

      if (widget.difficulty == 'IMPOSSIBLE') {
        tap('O', nextPlay(false));
      }
    }
  }

  Widget gameDifficulty(double screenHeight) {
    if (widget.difficulty != 'NONE') {
      return CustomText(
        text: widget.difficulty,
        color: colors.white,
        fontSize: screenHeight * 0.036
      );
    } else {
      return Container();
    }
  }

  Color symbolColor(int index) {
    if (board[index] == 'X') {
      return colors.blue;
    } else {
      return colors.red;
    }
  }

  Widget gameBoard(double screenHeight, double screenWidth) {
    return SizedBox(
      width: screenHeight * 0.45,
      child: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.03, 0.0, screenWidth * 0.03, 0.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                if (widget.computerPlaying) {
                  setState(() {
                    if (!computerTurn) {
                      play(index);
                      checkWinner(true);
                    }
                  });
                  computerTurn = true;
                  Future.delayed(const Duration(seconds: 1), (){
                    setState(() {
                      computerPlay();
                      checkWinner(true);
                      computerTurn = false;
                    });
                  });
                } else {
                  setState(() {
                    play(index);
                    checkWinner(true);
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: colors.lightGrey
                  ),
                  child: Center(
                    child: CustomText(
                      text: board[index],
                      color: symbolColor(index),
                      fontSize: screenHeight * 0.09
                    )
                  )
                )
              )
            );
          }
        )
      )
    );
  }

  Widget exitButton(double screenHeight, double screenWidth) {
    return CustomElevatedButton(
      text: 'EXIT',
      backgroundColor: colors.red,
      height: screenHeight,
      width: screenWidth,
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
    );
  }

  Widget bottomButtons(double screenHeight, double screenWidth) {
    if (playing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          exitButton(screenHeight, screenWidth)
        ]
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButton(
            text: 'PLAY AGAIN',
            backgroundColor: colors.blue,
            height: screenHeight,
            width: screenWidth,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => 
                PlayScreen(computerPlaying: widget.computerPlaying, difficulty: widget.difficulty)))
          ),
          SizedBox(width: screenWidth * 0.05),
          exitButton(screenHeight, screenWidth)
        ]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: colors.darkGrey,
          child: Center(
            child: Column(
              children: [
                const Flexible(child: FractionallySizedBox(heightFactor: 0.8)),
                gameInfo(screenSize.height),
                SizedBox(height: screenSize.height * 0.025),
                gameBoard(screenSize.height, screenSize.width),
                const Flexible(child: FractionallySizedBox(heightFactor: 0.32)),
                gameDifficulty(screenSize.height),
                SizedBox(height: screenSize.height * 0.05),
                bottomButtons(screenSize.height, screenSize.width)
              ]
            )
          )
        )
      )
    );
  }
}