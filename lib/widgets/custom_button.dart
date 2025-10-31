import 'package:flutter/material.dart';

import '../consts/colors.dart';
import 'custom_button_container.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backGroundColor;
  final double elevation;
  final double borderRadius;
  final double width;
  final double? height;
  final BoxDecoration? decoration;

  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.backGroundColor = ColorCode.primary600,
      this.elevation = 1,
      this.borderRadius = 8,
      this.decoration,
      this.width = double.infinity,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: decoration ?? BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: backGroundColor),
        padding: EdgeInsets.symmetric(vertical: 14.5),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
// CustomButtonContainer(
// height: height,
// width: width,
// TextButton(
// onPressed: onPressed,
// style: TextButton.styleFrom(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(borderRadius),
// ),
// backgroundColor: backGroundColor,
// elevation: elevation,
// ),
// child: child,
// ),
// decoration: decoration,
// )
