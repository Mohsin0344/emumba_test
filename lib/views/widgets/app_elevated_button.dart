import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  final Widget widget;
  final double? height;
  final Function() onTap;

  const AppElevatedButton({
    super.key,
    required this.widget,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: widget,
      ),
    );
  }
}
