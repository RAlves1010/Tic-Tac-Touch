import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_touch/src/constants/colors.dart' as colors;
import 'package:tic_tac_touch/src/screens/difficulty_screen.dart';
import 'package:tic_tac_touch/src/screens/play_screen.dart';
import 'package:tic_tac_touch/src/widgets/custom_elevated_button.dart';
import 'package:tic_tac_touch/src/widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget gameTitle(double screenHeight) {
    return Column(
      children: [
        CustomText(text: 'TIC', color: colors.white, fontSize: screenHeight * 0.09),
        CustomText(text: 'TAC', color: colors.white, fontSize: screenHeight * 0.09),
        CustomText(text: 'TOUCH', color: colors.white, fontSize: screenHeight * 0.09)
      ]
    );
  }

  Widget playButtons(BuildContext context, double screenHeight, double screenWidth) {
    return Column(
      children: [
        CustomElevatedButton(
          text: 'VS PLAYER',
          backgroundColor: colors.blue,
          height: screenHeight,
          width: screenWidth,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
              const PlayScreen(computerPlaying: false, difficulty: 'NONE')))
        ),
        SizedBox(height: screenHeight * 0.05),
        CustomElevatedButton(
          text: 'VS COMPUTER',
          backgroundColor: colors.red,
          height: screenHeight,
          width: screenWidth,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DifficultyScreen()))
        )
      ]
    );
  }

  Widget developerInfo(double screenHeight) {
    return CustomText(
      text: 'GAME DEVELOPED BY RÚBEN ALVES',
      color: colors.white,
      fontSize: screenHeight * 0.018
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: colors.darkGrey,
          child: Center(
            child: Column(
              children: [
                const Flexible(child: FractionallySizedBox(heightFactor: 0.75)),
                gameTitle(screenSize.height),
                const Flexible(child: FractionallySizedBox(heightFactor: 0.65)),
                playButtons(context, screenSize.height, screenSize.width),
                const Flexible(child: FractionallySizedBox(heightFactor: 0.95)),
                developerInfo(screenSize.height)
              ]
            )
          )
        )
      )
    );
  }
}