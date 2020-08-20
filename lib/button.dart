import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final String buttonTitle;
  final Function onPressed;
  final Color textColor;

  Button(
      {this.color, this.buttonTitle, @required this.onPressed, this.textColor});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01231),
      child: Material(
        elevation: screenHeight * 0.00615,
        color: color,
        borderRadius: BorderRadius.circular(screenHeight * 0.01231),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: screenWidth * 0.8,
          height: screenHeight * 0.05541,
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: textColor,
              fontSize: screenHeight * 0.0197,
            ),
          ),
        ),
      ),
    );
  }
}
