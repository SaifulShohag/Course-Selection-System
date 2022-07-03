
import 'package:artist_recruit/Widgets/user-profile/user-course-list.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCourseListScreen extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Courses', style: titleTextWhite,),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserCourseList(),
      ),
    );
  }
}