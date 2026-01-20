import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: SvgPicture.asset(AppAssets.imagesBack),
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.textStyleMedium18().copyWith(
              color: AppColor.black,
            ),
          ),
        ),
      ],
    );
  }
}
