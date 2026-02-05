import 'package:evently/Core/utils/app_color.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.isDark,
  });
  final int currentIndex;
  final Function(int)? onTap;
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: isDark ? Color(0xff000f30) : AppColor.white,
        primaryColor: AppColor.blue,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: isDark ? AppColor.dartBlue : AppColor.blue,
        unselectedItemColor: isDark ? AppColor.darkGrey : AppColor.grey2,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorite",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
