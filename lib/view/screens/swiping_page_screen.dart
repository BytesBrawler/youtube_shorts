import 'package:flutter/material.dart';
import 'package:youtube_shorts/controller/main_controller.dart';
import 'package:youtube_shorts/view/widget/bottom_nav_bar.dart';
import 'package:youtube_shorts/view/screens/video_player_screen.dart';

class CustomSwiper extends StatefulWidget {
  final int index;
  const CustomSwiper({Key? key, required this.index}) : super(key: key);

  @override
  CustomSwiperState createState() => CustomSwiperState();
}

class CustomSwiperState extends State<CustomSwiper> {

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    if (index == MainController.instance.videos.length - 1) {
      MainController.instance.loadMoreVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            // Swipe up
            MainController.instance.swipeUp();
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            // Swipe down
            MainController.instance.swipeDown();
          }
          _pageController.animateToPage(
            MainController.instance.currentIndex.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: MainController.instance.videos.length,
                onPageChanged: onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  return VideoPlayerScreen(
                    posts: MainController.instance.videos[index],
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,

                actions: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () { },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search), onPressed: () {  },

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar()
    );
  }
}
