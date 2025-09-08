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
  final double height;
  final BoxDecoration? decoration;

  const CustomButton(
      {Key? key,
        required this.child,
        required this.onPressed,
        this.backGroundColor =  ColorCode.primary600,
        this.elevation = 1,
        this.borderRadius = 8,
        this.decoration,
        this.width = double.infinity,
        this.height = 50
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButtonContainer(
      height: height,
      width: width,
      TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backGroundColor,
          elevation: elevation,
        ),
        child: child,
      ),
      decoration: decoration,
    );
  }
}

