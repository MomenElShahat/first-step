import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';

class CustomThumbShape extends RangeSliderThumbShape {
  final double thumbSize;
  final ui.Image? image; // pass a preloaded ui.Image

  CustomThumbShape({this.thumbSize = 24, this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size(thumbSize, thumbSize);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool isDiscrete = false,
        bool isEnabled = true,
        bool isOnTop = false,
        bool isPressed = false,
        required SliderThemeData sliderTheme,
        TextDirection? textDirection, // <- NOT required
        Thumb? thumb,                 // <- NOT required
      }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()..isAntiAlias = true;

    if (image != null) {
      final src = Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
      final dst = Rect.fromCenter(center: center, width: thumbSize, height: thumbSize);
      canvas.drawImageRect(image!, src, dst, paint);
    } else {
      // fallback (shows immediately while image loads)
      final c = sliderTheme.thumbColor ?? Colors.blue;
      canvas.drawCircle(center, thumbSize / 2, Paint()..color = c);
    }
  }
}
