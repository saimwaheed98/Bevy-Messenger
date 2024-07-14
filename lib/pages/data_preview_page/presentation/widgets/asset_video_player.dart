import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/cupertino.dart';

class AssetVideoPlayer extends StatefulWidget {
  final File file;
  const AssetVideoPlayer({super.key, required this.file});

  @override
  State<AssetVideoPlayer> createState() => _InternetVideoPlayerState();
}

class _InternetVideoPlayerState extends State<AssetVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file)
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
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: 300,
              maxWidth: getWidth(context),
              minWidth: getWidth(context)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController),
            ),
          ),
        ),
      ],
    );
  }
}
