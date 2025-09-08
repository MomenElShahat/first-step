import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void customSnackBar(String title, Color color){

  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
  // Get.snackbar(
  //     "", title ??"",
  //     margin: const EdgeInsets.only(bottom: 70,right:32,left: 32),
  //     titleText:const SizedBox(),
  //     messageText: CustomText(title ??"", textAlign: TextAlign.start, textStyle: TextStyles.textSmall.copyWith(
  //       fontWeight: FontWeight.w400,
  //       color: ColorCode.white,
  //     ),maxLines: 10),
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor:color,
  //     duration: const Duration(milliseconds: 3000),
  //     colorText: ColorCode.white,
  // );

}