import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/Widgets/text-input-field.dart';
import 'package:artist_recruit/main.dart';
import 'package:artist_recruit/Widgets/app-button.dart';
import 'package:artist_recruit/services/authencation-service.dart';
import 'package:artist_recruit/utils/constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authService = AuthenticationService(FirebaseAuth.instance);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool goThrough = true;

  userSignUp() async {
    if(goThrough) {
      goThrough = false;
      String msg = await authService.signUp(email: emailController.text.trim(),
      password: passwordController.text.trim()) ?? '';
      goThrough = true;
      if(msg == ' ') {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
      } else showAlertDialougue(context, title: 'Error Found', content: msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Account', style: titleTextWhite,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.0,),
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
                TextInputField(
                  label: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value.length < 6) {
                      return "Password must have 6 charecter!";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                AppButton(
                  title: 'Sign Up', 
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      userSignUp();
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
