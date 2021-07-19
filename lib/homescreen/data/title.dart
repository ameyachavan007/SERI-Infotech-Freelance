import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';

class TitleHome extends StatelessWidget {
  final String title;

  const TitleHome({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'GothamMedium',
          fontSize: 12.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
