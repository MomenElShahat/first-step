import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Themes {
  static final light = ThemeData(
    // useMaterial3: false,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorCode.primary600,
      surfaceTint: Colors.transparent,
    ),

    canvasColor: ColorCode.white, //change the color of appBar
    textTheme: GoogleFonts.tajawalTextTheme(),
    //brightness: Brightness.light //compare the BG color with text color
  );
}
