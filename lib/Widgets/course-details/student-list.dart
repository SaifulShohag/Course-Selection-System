import 'package:artist_recruit/Widgets/image-card.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  final List courseStudents;
  StudentList({@required this.courseStudents});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0,),
        if(courseStudents.length == 0) SizedBox(
          width: double.infinity,
          child: Text(
            'No student has Signed Up for this course yet', 
            textAlign: TextAlign.center,
          ),
        ), 
        for (var student in courseStudents) ImageCard(
          bottomMargin: 10.0,
          horizontalPadding: 6.0,
          verticalPadding: 2.0,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: lightBlackColor,
                radius: 21.0,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(student['userPhotoURL']),
                ),
              ), 
              SizedBox(width: 13.0,),
              Text(student['username'], style: subheadText,)
            ],
          ),
        ),
      ],
    );
  }
}