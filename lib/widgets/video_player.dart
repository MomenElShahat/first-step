import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import 'custom_text.dart';
import 'gaps.dart';

class MuxVideoPlayer extends StatefulWidget {
  final String playbackId;

  const MuxVideoPlayer({required this.playbackId, super.key});

  @override
  State<MuxVideoPlayer> createState() => _MuxVideoPlayerState();
}

class _MuxVideoPlayerState extends State<MuxVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    final String muxUrl = 'https://stream.mux.com/${widget.playbackId}.m3u8';

    _controller = VideoPlayerController.networkUrl(Uri.parse(muxUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });

    _controller.addListener(() {
      if (mounted) setState(() {}); // So time updates live
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _seekTo(Duration position) {
    if (_isInitialized) {
      _controller.seekTo(position);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours;
    return hours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isInitialized
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),

                  // Bigger progress bar with LTR direction
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        height: 10,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(),
                        ),
                      ),
                    ),
                  ),

                  // Play/Pause Button
                  PositionedDirectional(
                    bottom: 15,
                    end: 5,
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          Gaps.vGap8,
          // Timestamp Row
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    _formatDuration(_controller.value.position),
                    textStyle: TextStyles.body14Regular,
                  ),
                  CustomText(
                    _formatDuration(_controller.value.duration),
                    textStyle: TextStyles.body14Regular,
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : const SpinKitCircle(color: ColorCode.primary600),
    );
  }
}
