import 'package:artist_recruit/Widgets/image-card.dart';
import 'package:artist_recruit/screens/profile%20screens/user-profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:artist_recruit/Widgets/text-input-field.dart';
import 'package:artist_recruit/services/datastore-service.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBasicInfoScreen extends StatefulWidget {
  final student;
  UserBasicInfoScreen({@required this.student});

  @override
  State<UserBasicInfoScreen> createState() => _UserBasicInfoScreenState();
}

class _UserBasicInfoScreenState extends State<UserBasicInfoScreen> {
  final dataStoreService = DataStoreService();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final stuIDController = TextEditingController();
  final majorController = TextEditingController();

  final User user = FirebaseAuth.instance.currentUser;
  final String imageUrl = 'assets/images/cameraIcon.png';

  Map student = {};
  String userEmail = 'useremail@domain.com';

  @override
  void initState() {
    student = widget.student;
    userEmail = student['email'];
    nameController.text = student['fullName'];
    stuIDController.text = student['stuID'];
    majorController.text = student['major'];
    super.initState();
  }

  saveChanges() async {
    preventDoubleTap(context);
    await dataStoreService.updateStudentData(docID: student['id'], fullName: nameController.text.trim(), 
    stuID: stuIDController.text.trim(), major: majorController.text.trim());
    await user.updateDisplayName(nameController.text.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Info', style: titleTextWhite,),
        titleSpacing: 0,
        actions: [
          TextButton(
            onPressed: () async {
              if(_formKey.currentState.validate()) {
                await saveChanges();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> UserProfileScreen()), 
                (Route route) => route.isFirst);
              }
            },
            child: Text('Save', style: titleTextWhite,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                child: TextInputField(
                  label: 'Full Name',
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your Full Name';
                    } else if(value.length < 3) {
                      return 'Enter a valid full name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              ImageCard(
                horizontalPadding: 10.0,
                alignment: Alignment.centerLeft,
                child: Text('Email: $userEmail', style: subheadText,),
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                child: TextInputField(
                  label: 'Student ID',
                  controller: stuIDController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your Student ID';
                    } else if(value.length < 9) {
                      return 'Enter a valid Student ID';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0, width: double.infinity,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                child: TextInputField(
                  label: 'Major',
                  controller: majorController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your major';
                    } else if(value.length < 5) {
                      return 'Enter a valid major';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 50.0,),
            ],
          ),
        ),
      ),
    );
  }
}