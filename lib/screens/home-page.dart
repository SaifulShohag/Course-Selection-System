import 'package:artist_recruit/Widgets/app-top-bar.dart';
import 'package:artist_recruit/Widgets/home-page/course-list.dart';
import 'package:artist_recruit/screens/user-name-dp-form-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    if(user.photoURL == null || user.displayName == '') {
      return UserNameImage();
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppTopBar(user: user), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CourseList(),
      ),
    );
  }
}