import 'package:flutter/material.dart';
import 'package:artist_recruit/utils/constants.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Function validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  TextInputField({@required this.controller, this.label, this.hintText, this.validator, this.keyboardType, this.obscureText, 
  this.enabled, this.maxLines});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool obscured = false;
  IconData suffixIcon = Icons.visibility_outlined;

  @override
  void initState() {
    super.initState();
    obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled ?? true,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: obscured ?? false,
      validator: (value) {
        if(widget.validator != null) {
          return widget.validator(value);
        }
        return null;
      },
      cursorColor: lightBlackColor,
      decoration: InputDecoration(
        suffixIcon: Visibility(
          visible: widget.obscureText ?? false,
          child: IconButton(
            icon: Icon(suffixIcon),
            onPressed: () => setState(() {
              obscured = !obscured;
              suffixIcon == Icons.visibility_outlined ? 
              suffixIcon = Icons.visibility_off_outlined : suffixIcon = Icons.visibility_outlined;
            }),
          ),
        ),
        labelText: widget.label,
        labelStyle: textInputLabelText,
        hintText: widget.hintText,
        hintStyle: hintTextText,
        errorStyle: TextStyle(fontSize: 13.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textInputBorderColor,),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textInputBorderColor,),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red,),
        ),
      ),
      style: subtitleText,
    );
  }
}