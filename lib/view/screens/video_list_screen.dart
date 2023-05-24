import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/main_controller.dart';
import 'swiping_page_screen.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  VideoListScreenState createState() => VideoListScreenState();
}

class VideoListScreenState extends State<VideoListScreen> {
  late ScrollController scrollController;
  final controller = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    MainController.instance.fetchVideos();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      MainController.instance.loadMoreVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Youtube Shorts Clone'),
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.red,), // Show a loading indicator
            );
          } else {
            return ListView.builder(
              controller: scrollController,
              itemCount: (MainController.instance.videos.length + 1) ~/ 2,
              itemBuilder: (context, index) {
                final startIndex = index * 2;
                final endIndex = startIndex + 1;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _buildCard(startIndex),
                      ),
                    ),
                    if (endIndex < MainController.instance.videos.length)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildCard(endIndex),
                        ),
                      ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(int index) {
    final video = MainController.instance.videos[index];
    MainController.instance.currentIndex.value = index;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomSwiper(
              index: index,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: SizedBox(
          height: 250.0,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  video.submission.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          child: ClipOval(
                            child: Image.network(
                              video.creator.pic,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          video.creator.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      video.submission.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
