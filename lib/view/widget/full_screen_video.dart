import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/posts_model.dart';
import 'basic_overlay.dart';
import 'menu_items1.dart';
import 'menu_items2.dart';

class VideoPlayerFullscreenWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final Posts posts;

  const VideoPlayerFullscreenWidget({super.key,
    required this.controller, required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(alignment: Alignment.topCenter, child: buildVideo(context))
        : const Center(child: CircularProgressIndicator(color: Colors.red,));
  }

  Widget buildVideo(BuildContext context ) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        buildVideoPlayer(),
         BasicOverlayWidget(controller: controller),

        Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
                width: MediaQuery.of(context).size.width*0.85,
                child: MenuItems1(posts: posts,))),
        Positioned(
            bottom: 0,
            right: 0,
            child: MenuItem2(posts: posts))
      ],
    );
  }

  Widget buildVideoPlayer() {
    return buildFullScreen(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
