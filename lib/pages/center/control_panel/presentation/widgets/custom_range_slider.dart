import 'package:flutter/material.dart';

class CustomRangeSliderTrackShape extends RoundedRectRangeSliderTrackShape {
  final double radius;

  CustomRangeSliderTrackShape({this.radius = 5});

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset startThumbCenter,
        required Offset endThumbCenter,
        bool isEnabled = false,
        bool isDiscrete = false,
        double additionalActiveTrackHeight = 2, // 👈 NEW in Flutter 3.x
      }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final RRect rRect = RRect.fromRectAndRadius(trackRect, Radius.circular(radius));

    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()..color = sliderTheme.inactiveTrackColor!;

    final Rect leftSegment = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      startThumbCenter.dx,
      trackRect.bottom,
    );

    final Rect rightSegment = Rect.fromLTRB(
      endThumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );

    // active section
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(startThumbCenter.dx, trackRect.top, endThumbCenter.dx, trackRect.bottom),
        Radius.circular(radius),
      ),
      activePaint,
    );

    // left inactive section
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(leftSegment, Radius.circular(radius)),
      inactivePaint,
    );

    // right inactive section
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rightSegment, Radius.circular(radius)),
      inactivePaint,
    );
  }
}
