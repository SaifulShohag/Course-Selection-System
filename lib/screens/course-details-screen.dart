import 'package:artist_recruit/Widgets/course-details/student-list.dart';
import 'package:artist_recruit/main.dart';
import 'package:artist_recruit/services/datastore-service.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseDetailScreen extends StatefulWidget {
  final Map course;
  CourseDetailScreen({@required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final dataStoreService = DataStoreService();
  final User user = FirebaseAuth.instance.currentUser;
  List courseStudents = [];
  int userTotalAppliedCourses = 0;
  Map course;
  bool alreadyApplied = false;

  @override
  void initState() {
    super.initState();
    course = widget.course;
    getCourseStudents();
    getTotalCoursesCurrentUserApplied();
  }

  getCourseStudents() async {
    courseStudents = await dataStoreService.getCourseStudents(course['id']);
    setState(() {
      courseStudents = courseStudents;
      alreadyApplied = courseStudents.any((el) => el['uid'] == user.uid);
    });
  }

  getTotalCoursesCurrentUserApplied() async {
    List list = await dataStoreService.getStudentCourses(user.uid);
    userTotalAppliedCourses = list.length;
  }

  saveChanges() async {
    List updatedStudents = course['students'];
    updatedStudents.add(user.uid);
    await dataStoreService.applyToCourse(course['id'], user.uid, user.displayName, user.photoURL, updatedStudents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('Course Details', style: titleTextWhite),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if(course['maxStudents'] < course['students'].length) {
                if(userTotalAppliedCourses < 5) {
                  if(!alreadyApplied) {
                    preventDoubleTap(context);
                    await saveChanges();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthenticationWrapper()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CourseDetailScreen(course: course,)));
                  }
                } else {
                  showAlertDialougue(context, title: "Error", content: "Sorry, you can't apply to more than 5 courses.");
                }
              } else {
                showAlertDialougue(context, title: "Error", content: "Sorry, course's seats are full. Please try again next year.");
              }
            },
            child: Text(alreadyApplied ? 'Applied' : 'Apply', 
            style: alreadyApplied? titleTextGrey : titleTextWhite),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To apply to this course click on "Apply" button at the top right corner of the appbar.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.0, width: double.infinity,),
              Wrap(
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text('Course Code:', style: normalLightText,),
                  ),
                  Text(course['courseCode'], style: subheadLightText,),
                ],
              ),
              SizedBox(height: 15.0, width: double.infinity,),
              Wrap(
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text('Course Name:', style: normalLightText,),
                  ),
                  Text(course['courseName'], style: subheadLightText,),
                ],
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              Wrap(
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text('Course Teacher:', style: normalLightText,),
                  ),
                  Text(course['courseTeacher'], style: subheadLightText,),
                ],
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              Wrap(
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text('Total Seats:', style: normalLightText,),
                  ),
                  Text(course['maxStudents'].toString(), style: subheadLightText,),
                ],
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              Wrap(
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text('Seats Taken:', style: normalLightText,),
                  ),
                  Text('${course['students'].length}', style: subheadLightText,),
                ],
              ),
              SizedBox(height: 30.0, width: double.infinity,),
              Text('List Students:', style: titleText,),
              Container(
                height: 2.0,
                width: double.infinity,
                color: lightBlackColor,
              ),
              StudentList(courseStudents: courseStudents,),
            ],
          ),
        ),
      ),
    );
  }
}