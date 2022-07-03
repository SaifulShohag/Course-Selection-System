import 'dart:io';
import 'package:artist_recruit/Widgets/image-card.dart';
import 'package:artist_recruit/main.dart';
import 'package:artist_recruit/screens/profile%20screens/use-basic-info.dart';
import 'package:artist_recruit/screens/profile%20screens/user-course-list-screen.dart';
import 'package:artist_recruit/services/datastore-service.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artist_recruit/Widgets/bottom-modal.dart';
import 'package:artist_recruit/services/image-service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final dataStoreService = DataStoreService();
  final imageService = ImageService();
  final User user = FirebaseAuth.instance.currentUser;
  final String imageUrl = 'assets/images/cameraIcon.png';

  Map student = {};
  File images;
  String photoUrl;

  selectImage(BuildContext context) {
    bottomModal(context: context, children: [
      ListTile(
        leading: Icon(Icons.photo_library),
        title: Text('Photo Library'),
        onTap: () async {
          var value = await imageService.pickImageFromGallery();
          if(value != null) {
            cropProfileImage(value);
          }
          Navigator.of(context).pop();
        }
      ),
      ListTile(
        leading: Icon(Icons.photo_camera),
        title: Text('Camera'),
        onTap: () async {
          var value = await imageService.pickImageFromCamera();
          if(value != null) {
            cropProfileImage(value);
          }
          Navigator.of(context).pop();
        },
      ),
    ]);
  }

  Future cropProfileImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: secondaryBtnColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() => images = croppedFile);
      saveChanges();
    }
  }

  @override
  void initState() {
    getStudentData();
    super.initState();
  }

  getStudentData() async {
    student = await dataStoreService.getStudentData(context, user: user);
  }

  saveChanges() async {
    preventDoubleTap(context);
    if(images != null) {
      photoUrl = await imageService.reUploadImage(context, images, photoUrl);
      await user.updatePhotoURL(photoUrl);
      dataStoreService.updateProfilePicture(docID: student['id'], photoURL: photoUrl,);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthenticationWrapper()));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfileScreen()));    
    } else {
      showAlertDialougue(context, title: 'Error Found', content: 'You haven\'t selected any image! Choose an image to update your profile picture.');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('Profile', style: titleTextWhite,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0,),
            ImageCard(
              onTap:() => selectImage(context),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: size.width * 0.91,
                    child: CircleAvatar(
                      backgroundColor: blackTextColor,
                      radius: size.width * 0.45,
                      child: CircleAvatar(
                        radius: size.width * 0.445,
                        backgroundImage: images == null ?  NetworkImage(user.photoURL) : FileImage(images),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: FaIcon(FontAwesomeIcons.edit, size: 17.0,),
                      ),
                      SizedBox(width: 4.0,),
                      Text('Edit Profile Image', style: subheadText,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0, width: double.infinity,),
            ImageCard(
              horizontalPadding: 15.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Basic Info', style: subheadText,),
                  ),
                  FaIcon(FontAwesomeIcons.edit, size: 17.0,),
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserBasicInfoScreen(student: student,))),
            ),
            SizedBox(height: 10.0, width: double.infinity,),
            ImageCard(
              horizontalPadding: 15.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Your Courses', style: subheadText,),
                  ),
                  FaIcon(FontAwesomeIcons.edit, size: 17.0,),
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserCourseListScreen())),
            ),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}