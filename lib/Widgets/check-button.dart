import 'package:flutter/material.dart';

class CheckButton extends StatefulWidget {
  final Function onTap;
  final bool checked;
  CheckButton({@required this.onTap, @required this.checked});
  @override
  _CheckButtonState createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  IconData icon = Icons.check_box_outline_blank;
  @override
  void initState() {
    super.initState();
    icon = widget.checked ? Icons.check_box : Icons.check_box_outline_blank;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          if(icon == Icons.check_box_outline_blank) setState(() => icon = Icons.check_box);
          else setState(() => icon = Icons.check_box_outline_blank);
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(icon, size: 25.0,),
        ),
      ),
    );
  }
}