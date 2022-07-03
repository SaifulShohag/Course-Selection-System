// import 'package:flutter/material.dart';
// import 'package:artist_recruit/Widgets/app-button.dart';
// import 'package:artist_recruit/Widgets/text-input-field.dart';
// import 'package:artist_recruit/services/authencation-service.dart';
// import 'package:artist_recruit/utils/constants.dart';
// import 'package:provider/provider.dart';

// class ConfirmPasswordScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final codeController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPswdController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     onConfrimPassword() async {
//       String msg = await context.read<AuthenticationService>().confirmNewPassword(codeController.text.trim(), passwordController.text);
//       if(msg == ' ') {
//         Navigator.popUntil(context, (route) => route.isFirst);
//         showAlertDialougue(context, title: 'Successful!', content: 'You\'ve successfully changed your password.');
//       } else showAlertDialougue(context, title: 'Error!', content: msg);
//     }
    
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 160.0,),
//                 CircleAvatar(
//                   radius: 75.0,
//                   backgroundColor: Colors.white,
//                   child: CircleAvatar(
//                     radius: 70.0,
//                     backgroundImage: AssetImage('assets/images/logo.jpg'),
//                   ),
//                 ),
//                 SizedBox(height: 20.0,),
//                 TextInputField(
//                   label: "Code",
//                   keyboardType: TextInputType.emailAddress,
//                   controller: codeController,
//                   validator: (value) {
//                     // if (value.length != 12) {
//                     //   return "Enter the 12 digit code";
//                     // }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10.0),
//                 TextInputField(
//                   label: 'Password',
//                   keyboardType: TextInputType.visiblePassword,
//                   obscureText: true,
//                   controller: passwordController,
//                   validator: (value) {
//                     if (value.length < 6) {
//                       return "Password must have 6 charecter!";
//                     } else if(value != confirmPswdController.text) {
//                       return "Both passwords didn't match";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10.0,),
//                 TextInputField(
//                   label: 'Confirm Password',
//                   keyboardType: TextInputType.visiblePassword,
//                   obscureText: true,
//                   controller: confirmPswdController,
//                   validator: (value) {
//                     if (value.length < 6) {
//                       return "Password must have 6 charecter!";
//                     } else if(value != passwordController.text) {
//                       return "Both passwords didn't match";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10.0,),
//                 AppButton(
//                   title: 'Confirm', 
//                   onTap: () {
//                     if (_formKey.currentState.validate()) {
//                       onConfrimPassword();
//                     }
//                   }
//                 ),
//                 SizedBox(height: 25.0,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }