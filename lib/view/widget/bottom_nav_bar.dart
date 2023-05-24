import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 1;

  void onItemTapped(int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_filled),
          label: 'Shorts',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Library',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
