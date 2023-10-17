import 'package:flutter/material.dart';
import 'package:tic_tac_touch/src/constants/colors.dart' as colors;
import 'package:tic_tac_touch/src/screens/home_screen.dart';
import 'package:tic_tac_touch/src/screens/play_screen.dart';
import 'package:tic_tac_touch/src/widgets/custom_elevated_button.dart';
import 'package:tic_tac_touch/src/widgets/custom_text.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  Widget difficultyTitle(double screenHeight) {
    return CustomText(
      text: 'DIFFICULTY',
      color: colors.white,
      fontSize: screenHeight * 0.068
    );
  }

  Widget difficultyButton(String difficulty, BuildContext context, double screenHeight, double screenWidth) {
    return CustomElevatedButton(
      text: difficulty,
      backgroundColor: colors.blue,
      height: screenHeight,
      width: screenWidth,
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          PlayScreen(computerPlaying: true, difficulty: difficulty)))
    );
  }

  Widget difficultyButtons(BuildContext context, double screenHeight, double screenWidth) {
    return Column(
      children: [
        difficultyButton('EASY', context, screenHeight, screenWidth),
        SizedBox(height: screenHeight * 0.05),
        difficultyButton('MEDIUM', context, screenHeight, screenWidth),
        SizedBox(height: screenHeight * 0.05),
        difficultyButton('IMPOSSIBLE', context, screenHeight, screenWidth),
        SizedBox(height: screenHeight * 0.17),
        CustomElevatedButton(
          text: 'EXIT',
          backgroundColor: colors.red,
          height: screenHeight,
          width: screenWidth,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
        )
      ]
    );
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
                const Flexible(child: FractionallySizedBox(heightFactor: 0.74)),
                difficultyTitle(screenSize.height),
                const Flexible(child: FractionallySizedBox(heightFactor: 0.58)),
                difficultyButtons(context, screenSize.height, screenSize.width)
              ]
            )
          )
        )
      )
    );
  }
}