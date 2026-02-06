import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? AppAssets.imagesHomeAcitve
                  : AppAssets.imagesHome,
              color: isDark ? AppColor.dartBlue : AppColor.blue,
            ),
            label: context.loc.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? AppAssets.imagesHeartActive
                  : AppAssets.imagesHeart,
              color: isDark ? AppColor.dartBlue : AppColor.blue,
            ),
            label: context.loc.favorite,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? AppAssets.imagesUserActive
                  : AppAssets.imagesUser,
              color: isDark ? AppColor.dartBlue : AppColor.blue,
            ),
            label: context.loc.profile,
          ),
        ],
      ),
    );
  }
}
