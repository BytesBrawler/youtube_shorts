import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/posts_model.dart';
import '../widget/full_screen_video.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Posts posts;
  const VideoPlayerScreen({Key? key, required this.posts}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.posts.submission.mediaUrl)
    ..addListener(() => setState(() {}))
    ..setLooping(true)
    ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayerFullscreenWidget(controller: controller, posts:widget.posts,);
  }
}
