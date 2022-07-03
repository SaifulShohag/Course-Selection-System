import 'package:flutter/material.dart';
import 'package:artist_recruit/utils/constants.dart';

class FullImageScreen extends StatelessWidget {
  final String photoURL;
  FullImageScreen({@required this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Image(
          image: NetworkImage(photoURL != '' 
          ? photoURL ?? noImage : noImage),
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ),
    );
  }
}