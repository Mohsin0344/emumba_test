import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color color;

  const AppLoadingIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(
        color: color,
      ); // iOS style loader
    } else {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    }
  }
}
