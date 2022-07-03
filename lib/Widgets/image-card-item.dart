import 'package:flutter/material.dart';
import 'package:artist_recruit/utils/constants.dart';

class ImageCardItem extends StatelessWidget {
  final String label;
  final Widget image;
  ImageCardItem({@required this.label, @required this.image});

  final String imageUrl = 'assets/images/cameraIcon.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        SizedBox(height: 5.0,),
        Text(label, style: subheadText,),
      ],
    );
  }
}