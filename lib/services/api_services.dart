import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/posts_model.dart';

class VideoService {
  static const String apiUrl =
      'https://internship-service.onrender.com/videos?page=';


  static Future<List<Posts>> fetchVideos(int page) async {
    final response = await http.get(Uri.parse(apiUrl + page.toString()));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final videosData = jsonData['data']['posts'] as List<dynamic>;

      return videosData.map((videoData) {
        final creatorData = videoData['creator'];
        final commentData = videoData['comment'];
        final reactionData = videoData['reaction'];
        final submissionData = videoData['submission'];

        return Posts(
          postId: videoData['postId'],
          creator: Creator(
            name: creatorData['name'] ?? '',
            id: creatorData['id'] ?? '',
            handle: creatorData['handle'] ?? '',
            pic: creatorData['pic'] ?? '',
          ),
          comment: Comment(
            count: commentData['count'] ?? 0,
            commentingAllowed: commentData['commentingAllowed'] ?? false,
          ),
          reaction: Reaction(
            count: reactionData['count'] ?? 0,
            voted: reactionData['voted'] ?? false,
          ),
          submission: Submission(
            title: submissionData['title'] ?? '',
            description: submissionData['description'] ?? '',
            mediaUrl: submissionData['mediaUrl'] ?? '',
            thumbnail: submissionData['thumbnail'] ?? '',
            hyperlink: submissionData['hyperlink'] ?? '',
          ),
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch videos');
    }
  }

}
