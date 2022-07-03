import 'package:flutter/material.dart';
import 'package:artist_recruit/utils/constants.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final double horizontalPadding;
  final double verticalPadding;
  final Color buttonColor;
  final TextStyle textStyle;

  AppButton({@required this.title, @required this.onTap, this.horizontalPadding, this.verticalPadding, 
  this.buttonColor, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.transparent),
        ),
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 7.0, horizontal: horizontalPadding ?? 20.0),
        primary: buttonColor ?? buttonColor,
      ),
      onPressed: onTap,
      child: Text(this.title, style: textStyle ?? buttonTextBold),
    );
  }
}
