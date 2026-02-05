import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChooseTimeAndDateWidget extends StatelessWidget {
  const ChooseTimeAndDateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.dec,
    this.onTap, required this.isDark,
  });
  final String icon;
  final String title;
  final String dec;
  final Function()? onTap;
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, color:isDark ? AppColor.dartBlue :  AppColor.blue),
        SizedBox(width: 8),
        Text(title, style: AppStyles.textStyleMedium16(color: isDark ?  AppColor.white:  AppColor.black)),
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Text(
            dec,
            style: AppStyles.textStyleRegular14(color: isDark ? AppColor.dartBlue :  AppColor.blue).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: isDark ? AppColor.dartBlue : AppColor.blue,
            ),
          ),
        ),
      ],
    );
  }
}
