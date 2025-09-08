import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenMediaViewer extends StatefulWidget {
  final String url;
  final bool isVideo;

  const FullScreenMediaViewer({
    super.key,
    required this.url,
    this.isVideo = false,
  });

  @override
  State<FullScreenMediaViewer> createState() => _FullScreenMediaViewerState();
}

class _FullScreenMediaViewerState extends State<FullScreenMediaViewer> {
  late VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _videoController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {});
          _videoController!.play();
        });
    } else {
      _videoController = null;
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Center(
          child: widget.isVideo
              ? (_videoController?.value.isInitialized ?? false)
              ? AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          )
              : const CircularProgressIndicator()
              : InteractiveViewer(
            child: Image.network(widget.url, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
