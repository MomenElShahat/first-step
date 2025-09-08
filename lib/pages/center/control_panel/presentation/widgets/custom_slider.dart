import 'dart:async';
import 'dart:ui' as ui;
import 'package:first_step/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/portfolio_prices_model.dart';
import '../controllers/control_panel_controller.dart';
import 'custom_slider_thumb.dart';

class CustomRangeSlider extends StatefulWidget {
  final ControlPanelController ctrl;
  final PortfolioPrice program;
  const CustomRangeSlider({super.key, required this.ctrl, required this.program});

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  ui.Image? _thumb;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadThumb('assets/images/thumb.png');
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // safe here because context is fully available
    _loadThumb('assets/images/thumb.png');
  }

  Future<void> _loadThumb(String asset) async {
    final cfg = createLocalImageConfiguration(context);
    final stream = AssetImage(asset).resolve(cfg);
    final completer = Completer<ui.Image>();
    late final ImageStreamListener listener;

    listener = ImageStreamListener((ImageInfo info, _) {
      stream.removeListener(listener);
      completer.complete(info.image);
    }, onError: (error, stack) {
      stream.removeListener(listener);
      completer.completeError(error, stack);
    });

    stream.addListener(listener);
    final img = await completer.future;
    if (mounted) setState(() => _thumb = img);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 10,
          activeTrackColor: ColorCode.primary500,      // match your primary500
          inactiveTrackColor: ColorCode.primary50,
          overlayShape: SliderComponentShape.noOverlay,
          rangeThumbShape: CustomThumbShape(
            thumbSize: 24,
            image: _thumb, // preloaded ui.Image
          ),
          // optional: rounded track ends like in your image
          trackShape: const RoundedRectSliderTrackShape(),
          thumbColor: Colors.transparent, // we draw the image ourselves
        ),
        child: RangeSlider(
          values: widget.ctrl.rangeValues.value,
          min: 1,
          max: 10,
          onChanged: (v) {
            widget.ctrl.rangeValues.value = v;
            widget.program.startAge = widget.ctrl.rangeValues.value.start.toInt();
            widget.program.endAge = widget.ctrl.rangeValues.value.end.toInt();
          },
        ),
      );
    });
  }
}
