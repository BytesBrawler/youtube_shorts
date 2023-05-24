import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            controller.value.isPlaying ? controller.pause() : controller.play(),
        child: Stack(
          children: <Widget>[
            buildPlay(),
          ],
        ),
      );



  Widget buildPlay() {
    return controller.value.isPlaying
        ? Container()
        : Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 80),
          );
  }
}
