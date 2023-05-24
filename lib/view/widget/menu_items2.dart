import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/posts_model.dart';

class MenuItem2 extends StatefulWidget {
  final Posts posts;

  const MenuItem2({Key? key, required this.posts}) : super(key: key);

  @override
  State<MenuItem2> createState() => _MenuItem2State();
}

class _MenuItem2State extends State<MenuItem2> {
  int likes = 0;
  bool isTapped = false;
  bool isdisLikeTapped = false;
  int msgCount = 0;
  bool msgAllowed = true;

  void updateLikes() {
    setState(() {
      isTapped ? likes++ : likes--;
    });
  }

  void changeLike() {
    setState(() {
      isTapped = !isTapped;
      updateLikes();
    });
  }

  void changeDislike(){
   setState(() {
     isdisLikeTapped = !isdisLikeTapped;
   });
  }
  void upMsgCount(){
    setState(() {
      msgCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    likes = widget.posts.reaction.count;
    isTapped = widget.posts.reaction.voted;
    msgCount = widget.posts.comment.count;
    msgAllowed = widget.posts.comment.commentingAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    changeLike();
                  });
                },
                child: isTapped
                    ? const Icon(Icons.thumb_up, color: Colors.blue, size: 40)
                    : const Icon(Icons.thumb_up, color: Colors.white, size: 40),
              ),
              Text(likes.toString()),
            ],
          ),
          const SizedBox(height: 20),

          InkWell(
            onTap: () {
             changeDislike();
            },
            child: isdisLikeTapped
                ? const Icon(Icons.thumb_down, color: Colors.blue, size: 40)
                : const Icon(Icons.thumb_down, color: Colors.white, size: 40),
          ),

          const SizedBox(height: 20,),
          msgAllowed ? InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Write a message'),
                    content: TextField(
                      decoration: const InputDecoration(hintText: 'Enter your message'),
                      onChanged: (value) {

                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                            upMsgCount();
                          Get.snackbar("comment", "done");
                          Navigator.pop(context);
                        },
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.comment_rounded,color: Colors.white,size:40)) : const Icon(Icons.no_encryption_outlined,color:Colors.white,size:40),

          Text(msgCount.toString()),

          const SizedBox(height: 20),

          InkWell(
            onTap: () async{
              await Share.share(widget.posts.submission.hyperlink);
            },
              child: const Icon(Icons.share,color: Colors.white,size: 40,),
            ),

          const SizedBox(height: 20),


        ],
      ),
    );
  }
}
