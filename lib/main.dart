import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_touch/src/screens/home_screen.dart';

void main() {
  runApp(const TicTacTouch());
}

class TicTacTouch extends StatelessWidget {
  const TicTacTouch({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}