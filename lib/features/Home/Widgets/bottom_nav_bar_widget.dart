import 'package:evently/Core/utils/app_color.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key, required this.currentIndex, this.onTap});
  final int currentIndex;
  final Function(int)? onTap;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColor.blue,
      unselectedItemColor: AppColor.grey2,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Favorite",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}