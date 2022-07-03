import 'package:artist_recruit/screens/profile%20screens/user-profile-screen.dart';
import 'package:artist_recruit/services/datastore-service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artist_recruit/services/authencation-service.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/main.dart';

class AppTopBar extends StatelessWidget {
  final User user;
  AppTopBar({this.user});
  final authService = AuthenticationService(FirebaseAuth.instance);
  final dataStoreService = DataStoreService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 55.0,
      titleSpacing: 7.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(user.displayName.toUpperCase().split(' ')[0], style: subtitleBoldWhiteText,),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0, bottom: 1.0,),
        child: CircleAvatar(
          backgroundColor: lightBlackColor,
          child: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(user.photoURL),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.person_sharp,
          ), 
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.login_outlined,
          ), 
          onPressed: () async {
            await authService.signOut();
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
          },
        ),
      ],
    );
  }
}