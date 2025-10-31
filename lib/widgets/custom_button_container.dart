import 'package:flutter/material.dart';

class CustomButtonContainer extends StatelessWidget {
  double? width;
  double? height;
  final Widget buttonWidget;
  final BoxDecoration? decoration;

  CustomButtonContainer(this.buttonWidget, {this.width, this.height, this.decoration, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width ?? double.infinity,
        // height: height ??50,
        decoration: decoration,
        padding: EdgeInsets.symmetric(vertical: 14.5),
        child: buttonWidget,
      ),
    );
  }
}
