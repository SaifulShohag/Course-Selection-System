import 'package:artist_recruit/utils/constants.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double horizontalPadding;
  final double topMargin;
  final double bottomMargin;
  final AlignmentGeometry alignment;
  final Function onTap;
  final Color backgroundColor;
  ImageCard({@required this.child, this.verticalPadding, this.horizontalPadding, this.onTap, this.alignment, 
  this.backgroundColor, this.topMargin, this.bottomMargin});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap:  onTap,
      child: Container(
        width: size.width * 0.95,
        margin: EdgeInsets.only(top: topMargin ?? 0.0, bottom: bottomMargin ?? 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: lightBlackColor),
          color: Colors.white
        ),
        alignment: alignment ?? Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12.0, horizontal: horizontalPadding ?? 0.0),
          child: child,
        ),
      ),
    );
  }
}