import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: AppColor.offWhite),
        padding: EdgeInsets.symmetric(vertical: 74, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 58,
              backgroundColor: AppColor.blue,
              child: Image.asset(
                AppAssets.imagesRoute,
                color: AppColor.white,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.height * 0.02), //! 16
            Text(
              "John Safwat",
              textAlign: TextAlign.center,
              style: AppStyles.textStyleSemiBold20(color: AppColor.black),
            ),
            SizedBox(height: 4),
            Text(
              "johnsafwat.route@gmail.com",
              textAlign: TextAlign.center,
              style: AppStyles.textStyleRegular14(color: AppColor.grey),
            ),
            SizedBox(height: size.height * 0.039), //! 32
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark mode",
                    style: AppStyles.textStyleMedium16(color: AppColor.black),
                  ),
                  SizedBox(
                    height: 16,
                    child: Switch(
                      padding: EdgeInsets.zero,
                      activeThumbColor: AppColor.white,
                      activeTrackColor: AppColor.blue,
                      inactiveThumbColor: AppColor.white,
                      inactiveTrackColor: AppColor.grey2,
                      value: value,
                      onChanged: (value) {
                        this.value = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02), //! 16
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: AppStyles.textStyleMedium16(color: AppColor.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppAssets.imageArrowRight,
                      color: AppColor.blue,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02), //! 16
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: AppStyles.textStyleMedium16(color: AppColor.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppAssets.imageLogout,
                      color: AppColor.red,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
