import 'package:artist_recruit/Widgets/app-button.dart';
import 'package:flutter/material.dart';

const String addImgUrl = 'https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_960_720.png';
const String noImage = 'https://rentalzone.in/public/frontend/images/no-image-found.png?v=1629805409';
Color primaryColor = Color(0xff259c72);
Color buttonColor = Color(0xff1274e0);
Color secondaryBtnColor = Color(0xffe0e0e0);
Color whiteButtonColor = Colors.white;
Color iconBtnColorWhite = Color(0xffffffff);

Color buttonTextColor = Color(0xffffffff);
Color secondarButtonTextColor = Color(0xff282728);

Color textInputBorderColor = Color(0xff282728);
Color blackTextColor = Color(0xff282728);
Color lightBlackColor = Color(0xff525151);

TextStyle homePageText = TextStyle(
  color: blackTextColor,
  fontSize: 20,
);

TextStyle titleText = TextStyle(
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  fontSize: 16,
);

TextStyle titleTextWhite = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16,
);

TextStyle titleTextGrey = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.grey[200],
  fontSize: 16,
);

TextStyle subheadText = TextStyle(
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  fontSize: 15,
);

TextStyle subheadLightText = TextStyle(
  fontWeight: FontWeight.bold,
  color: lightBlackColor,
  fontSize: 15,
);

TextStyle subtitleText = TextStyle(
  color: blackTextColor,
  fontSize: 14.0
);

TextStyle subtitleBoldWhiteText = TextStyle(
  color: Colors.white,
  fontSize: 14.0,
  fontWeight: FontWeight.bold
);

TextStyle textInputLabelText = TextStyle(
  color: blackTextColor,
  fontSize: 15,
);

TextStyle smallText = TextStyle(
  fontSize: 13.0,
  color: blackTextColor,
);

TextStyle normalLightText = TextStyle(
  fontSize: 14.0,
  color: lightBlackColor,
);

TextStyle normalTextBold = TextStyle(
  fontSize: 14.0,
  color: blackTextColor,
  fontWeight: FontWeight.bold
);

TextStyle hintTextText = TextStyle(
  color: Colors.grey,
);

TextStyle buttonText = TextStyle(
  color: buttonTextColor, 
  fontSize: 14.0
);

TextStyle buttonTextBlack = TextStyle(
  color: secondarButtonTextColor, 
  fontSize: 14.0
);

TextStyle buttonTextBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: buttonTextColor, 
  fontSize: 15.0,
);

TextStyle secondaryButtonText = TextStyle(
  fontWeight: FontWeight.bold,
  color: secondarButtonTextColor, 
  fontSize: 15.0,
);

TextStyle redTextStyle = TextStyle(
  color: Colors.red[700], 
  fontSize: 15.0
);


TextStyle interestItemText = TextStyle(
  color: blackTextColor,
  fontSize: 16.0,
);

TextStyle giftTitle = TextStyle(
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  fontSize: 15.0,
);

TextStyle uaTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: blackTextColor,
  fontSize: 15.0,
);


preventDoubleTap(context) {
  showDialog(context: context, builder:(context) => WillPopScope(onWillPop: () async => false, child: Center(child: CircularProgressIndicator())));
}

showAlertDialougue(context, {String title, String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(title,),
          ),
        ),
        contentPadding: EdgeInsets.only(top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
        content: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(content, style: textInputLabelText, textAlign: TextAlign.center,),
            SizedBox(height: 35.0, width: double.infinity,),
            AppButton(title: 'Close', textStyle: buttonText, horizontalPadding: 18.0, verticalPadding: 4.0, onTap: () => Navigator.pop(context)),
          ],
        ),
      );
    },
  );
}

showConfirmationDialouge(context, {String title, String content, Function onConfirm}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(title),
          ),
        ),
        contentPadding: EdgeInsets.only(top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
        content: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(content, style: textInputLabelText, textAlign: TextAlign.center,),
            SizedBox(height: 35.0, width: double.infinity,),
            AppButton(title: 'Cancel', textStyle: buttonText, horizontalPadding: 18.0, verticalPadding: 4.0, onTap: () => Navigator.pop(context)),
            SizedBox(width: 10.0,),
            AppButton(title: 'Confirm', buttonColor: secondaryBtnColor, textStyle: buttonTextBlack, horizontalPadding: 18.0, verticalPadding: 4.0, onTap: onConfirm),
          ],
        ),
      );
    },
  );
}

getInputDecoration({String hintText, Color color, double borderRadius}) {
  return InputDecoration(
    filled: true,
    fillColor: color,
    hintText: hintText,
    hintStyle: TextStyle( fontSize: 14.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    contentPadding: EdgeInsets.only(left: 20.0, top: 10.0),
  );
}