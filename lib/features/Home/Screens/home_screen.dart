import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: AppColor.offWhite),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03), //! 24
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome Back ✨",
                      style: AppStyles.textStyleRegular14(),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "John Safwat",
                      style: AppStyles.textStyleMedium20().copyWith(
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.imagesSun,
                        color: AppColor.blue,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.blue,
                      ),
                      child: Text(
                        "EN",
                        style: AppStyles.textStyleSemiBold14().copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            CategoriesTabBar(
              categories: AppHelper.categories,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
