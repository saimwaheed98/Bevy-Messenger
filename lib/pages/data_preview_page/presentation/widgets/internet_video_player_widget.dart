import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class InternetVideoPlayer extends StatefulWidget {
  final String url;
  const InternetVideoPlayer({super.key, required this.url});

  @override
  State<InternetVideoPlayer> createState() => _InternetVideoPlayerState();
}

class _InternetVideoPlayerState extends State<InternetVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
