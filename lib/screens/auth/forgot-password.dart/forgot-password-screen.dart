import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/Widgets/app-button.dart';
import 'package:artist_recruit/Widgets/text-input-field.dart';
import 'package:artist_recruit/services/authencation-service.dart';
import 'package:artist_recruit/utils/constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final authService = AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    onForgotPassword() async {
      String msg = await authService.forgotPassword(emailController.text.trim());
      if(msg == ' ') {
        Navigator.pop(context);
        showAlertDialougue(context, title: 'Successful', content: 'A Link has been sent to your email to reset your password. Click on that link and set your new password.');
      } else showAlertDialougue(context, title: 'Error Found', content: msg);
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: titleTextWhite,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 160.0,),
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 20.0,),
                TextInputField(
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                AppButton(
                  title: 'Confirm', 
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      onForgotPassword();
                    }
                  }
                ),
                SizedBox(height: 25.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}