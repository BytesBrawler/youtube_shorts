import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/posts_model.dart';
import '../services/api_services.dart';

class MainController extends GetxController {
  static MainController instance = Get.find();
Rx<bool> isLoading = true.obs;
  Rx<int> currentPage = 0.obs;
  RxList<Posts> videos = <Posts>[].obs;
  Rx<int> currentIndex = 0.obs;



  Rx<bool> isSubscribed = false.obs;
  void changeSubscription() {
    isSubscribed.value = !isSubscribed.value;
  }



  void swipeUp() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  void swipeDown() {
    if (currentIndex.value < videos.length - 1) {
      currentIndex.value++;
    }
  }

  Future<void> fetchVideos() async {
    try {
      final fetchedVideos = await VideoService.fetchVideos(currentPage.value);
      videos.addAll(fetchedVideos);
      isLoading.value=false;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      Get.snackbar(
        'Error',
        'Failed to fetch videos. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void loadMoreVideos() {
    currentPage.value++;
    fetchVideos();

  }
}



