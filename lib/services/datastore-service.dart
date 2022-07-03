import 'package:artist_recruit/screens/home-page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataStoreService {
  final dataStore =  FirebaseFirestore.instance;

  Future createNewUser(User user, {@required String fullName, @required String stuID, @required String major, @required String photoURL}) async {
    var newUser = await dataStore.collection('students').add({
      'uid': user.uid,
      'fullName': fullName ?? user.displayName,
      'stuID': stuID,
      'major': major,
      'photoURL': photoURL ?? user.photoURL,
      'email': user.email,
    });
    return newUser;
  }
  
  Future getStudentData(context, {User user}) async {
    Map data = {};
    String id = '';
    var res = await dataStore.collection('students').where('uid', isEqualTo: user.uid).get();
    if(res.docs.length < 1) {
      await user.updateDisplayName('');
      await user.updatePhotoURL(null);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      res.docs.forEach((element) {
        id = element.id;
        data = element.data();
      });
      return {'id': id, ...data};
    }
  }

  Future getStudentDataByUid(String uid) async {
    Map data = {};
    var res = await dataStore.collection('students').where('uid', isEqualTo: uid).get();
    res.docs.forEach((element) {
      data = {'id': element.id, ...element.data()};
    });
    return data;
  }

  Future updateStudentData({String docID, String fullName, String stuID, String major}) async {
    await dataStore.collection('students').doc(docID).update({
      'fullName': fullName,
      'stuID': stuID,
      'major': major,
    });
    return 'done';
  }

  Future updateDisplayName({String docID, String fullName}) async {
    await dataStore.collection('students').doc(docID).update({
      'fullName': fullName,
    });
    return 'done';
  }

  Future updateProfilePicture({String docID, String photoURL}) async {
    await dataStore.collection('students').doc(docID).update({
      'photoURL': photoURL,
    });
    return 'done';
  }

  Future deleteImagefromStorage(String url) async {
    if(Uri.tryParse(url ?? '')?.hasAbsolutePath ?? false) FirebaseStorage.instance.refFromURL(url)
      .delete().catchError((_) => '');
    return 'done';
  }

  Future createCourses(String code, String name, String teacherName, int maxStudents) async {
    var res = await dataStore.collection('courses').add({
      'courseCode': code,
      'courseName': name,
      'courseTeacher': teacherName,
      'maxStudents': maxStudents,
      'students': []
    });
    return res;
  }

  Future getAllCourses() async {
    List data = [];
    var res = await dataStore.collection('courses').get();
    res.docs.forEach((element) {
      data.add({'id': element.id, ...element.data()});
    });
    return data ?? [];
  }

  Future getCoursesByDocID(String docID) async {
    Map data = {};
    var res = await dataStore.collection('courses').doc(docID).get();
    data = {'id': res.id, ...res.data()};
    return data;
  }

  Future updateCourseStudents({String docID, List students}) async {
    await dataStore.collection('courses').doc(docID).update({
      'students': students,
    });
    return 'done';
  }

  Future applyToCourse(String courseDocID, String uid, String username, String userPhotoURL, List courseStudents) async {
    var res = await dataStore.collection('appliedCourses').add({
      'courseDocID': courseDocID,
      'uid': uid,
      'username': username,
      'userPhotoURL': userPhotoURL
    });
    updateCourseStudents(docID: courseDocID, students: courseStudents);
    return res;
  }

  Future getCourseStudents(String courseDocID) async {
    List data = [];
    var res = await dataStore.collection('appliedCourses').where('courseDocID', isEqualTo: courseDocID).get();
    res.docs.forEach((element) {
      data.add({'id': element.id, ...element.data()});
    });
    return data ?? [];
  }

  Future getStudentCourses(String uid) async {
    List data = [];
    var res = await dataStore.collection('appliedCourses').where('uid', isEqualTo: uid).get();
    res.docs.forEach((element) {
      data.add({'id': element.id, ...element.data()});
    });
    return data ?? [];
  }
}