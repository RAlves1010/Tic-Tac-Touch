import 'package:flutter/material.dart';
import 'package:tic_tac_touch/src/constants/colors.dart' as colors;
import 'package:tic_tac_touch/src/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double height;
  final double width;
  final Function onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.height,
    required this.width,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 5.0,
        fixedSize: Size(width * 0.45, height * 0.08)
      ),
      onPressed: () => onPressed(),
      child: CustomText(text: text, color: colors.white, fontSize: height * 0.036)
    );
  }
}