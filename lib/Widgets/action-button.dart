import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  ActionButton({@required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        child: Icon(icon, size: 25.0,),
      ),
    );
  }
}