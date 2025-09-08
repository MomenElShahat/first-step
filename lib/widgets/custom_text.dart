import 'package:first_step/consts/colors.dart';
import 'package:flutter/material.dart';

import '../consts/text_styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const CustomText(this.text,
      {super.key,
      this.textStyle,
      this.maxLines = 2,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? TextStyles.body16Medium,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
