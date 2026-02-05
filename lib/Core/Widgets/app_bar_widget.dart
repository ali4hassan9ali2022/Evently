
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title, required this.isDark});
  final String title;
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark
                          ? AppColor.darkBlue2
                          : AppColor.offWhite,
                    ),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: isDark ? AppColor.white : AppColor.blue,
                    )),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.textStyleMedium18().copyWith(
              color: isDark ? AppColor.white : AppColor.black,
            ),
          ),
        ),
      ],
    );
  }
}
