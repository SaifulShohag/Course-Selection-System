import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/Widgets/text-input-field.dart';
import 'package:artist_recruit/main.dart';
import 'package:artist_recruit/screens/auth/forgot-password.dart/forgot-password-screen.dart';
import 'package:artist_recruit/Widgets/app-button.dart';
import 'package:artist_recruit/screens/auth/signUp-page.dart';
import 'package:artist_recruit/services/authencation-service.dart';
import 'package:artist_recruit/utils/constants.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final authService = AuthenticationService(FirebaseAuth.instance);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool goThrough = true;

  userSignIn() async {
    if(goThrough) {
      goThrough = false;
      String msg = await authService.signIn(email: emailController.text.trim(),
      password: passwordController.text.trim());
      goThrough = true;
      if(msg == ' ') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
      } else showAlertDialougue(context, title: 'Error Found', content: msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton(
                      title: 'Sign In', 
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          userSignIn();
                        }
                      }
                    ),
                    SizedBox(width: 15.0,),
                    AppButton(
                      title: 'Sign Up', 
                      buttonColor: secondaryBtnColor,
                      textStyle: secondaryButtonText,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUpPage()));
                      }
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen())), 
                  child: Text('Forgot Password? Click here', style: TextStyle(color: blackTextColor),),
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
