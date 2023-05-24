
class Posts {
  final String postId;
  final Creator creator;
  final Comment comment;
  final Reaction reaction;
  final Submission submission;

  Posts({
    required this.postId,
    required this.creator,
    required this.comment,
    required this.reaction,
    required this.submission,
  });
}

class Creator {
  final String name;
  final String id;
  final String handle;
  final String pic;

  Creator({
    required this.name,
    required this.id,
    required this.handle,
    required this.pic,
  });
}

class Comment {
  final int count;
  final bool commentingAllowed;

  Comment({
    required this.count,
    required this.commentingAllowed,
  });
}

class Reaction {
  final int count;
  late final bool voted;

  Reaction({
    required this.count,
    required this.voted,
  });
}

class Submission {
  final String title;
  final String description;
  final String mediaUrl;
  final String thumbnail;
  final String hyperlink;

  Submission({
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.thumbnail,
    required this.hyperlink,
  });
}
