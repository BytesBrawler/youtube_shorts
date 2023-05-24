import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/main_controller.dart';
import '../../models/posts_model.dart';

class MenuItems1 extends StatefulWidget {
  final Posts posts;
  const MenuItems1({Key? key, required this.posts}) : super(key: key);

  @override
  State<MenuItems1> createState() => _MenuItems1State();
}

class _MenuItems1State extends State<MenuItems1> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
    //  width: MediaQuery.of(context).size.width*0.80,
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 110),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        child: ClipOval(
                          child: Image.network(
                            widget.posts.creator.pic,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.posts.creator.handle,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            MainController.instance.changeSubscription();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MainController
                                    .instance.isSubscribed.value
                                ? Colors.transparent
                                : Colors
                                    .red, // Set the button background color to red
                          ),
                          child: Text(
                            MainController.instance.isSubscribed.value
                                ? 'Subscribed'
                                : 'Subscribe',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  //const SizedBox(height: 20,),

                  Text(widget.posts.submission.title,style: TextStyle(fontSize: 20),)
                ],
              )
            ],
          )
        ]));
  }
}
