import 'package:artist_recruit/Widgets/image-card.dart';
import 'package:artist_recruit/screens/course-details-screen.dart';
import 'package:artist_recruit/services/datastore-service.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final dataStoreService = DataStoreService();

  getAllCourses() async {
    return await dataStoreService.getAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllCourses(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
          List courseList = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                for (var course in courseList) ImageCard(
                  horizontalPadding: 15.0,
                  bottomMargin: 13.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(course['courseName'], style: subheadText,),
                      ),
                      Text('${course['students'].length}/${course['maxStudents']}', style: subheadLightText,),
                    ],
                  ),
                  onTap: () => 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen(course: course,))),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }
}