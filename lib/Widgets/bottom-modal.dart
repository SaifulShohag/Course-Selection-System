import 'package:flutter/material.dart';

bottomModal({@required BuildContext context, @required List<Widget> children}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0,),
          child: Wrap(
            children: children,
          ),
        ),
      );
    }
  );
}