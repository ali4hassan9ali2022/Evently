import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return SafeArea(
      child: Container(
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
              userProvider.userModel!.name,
              textAlign: TextAlign.center,
              style: AppStyles.textStyleSemiBold20(
                color: isDark ? AppColor.white : AppColor.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              userProvider.userModel!.email,
              textAlign: TextAlign.center,
              style: AppStyles.textStyleRegular14(
                color: isDark ? AppColor.darkGrey : AppColor.grey,
              ),
            ),
            SizedBox(height: size.height * 0.039), //! 32
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Color(0xff002678) : AppColor.lightGrey,
                ),
                color: isDark ? AppColor.darkBlue2 : AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark mode",
                    style: AppStyles.textStyleMedium16(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, prov, child) {
                      return SizedBox(
                        height: 16,
                        child: Switch(
                          padding: EdgeInsets.zero,
                          activeThumbColor: AppColor.white,
                          activeTrackColor: AppColor.dartBlue,
                          inactiveThumbColor: AppColor.white,
                          inactiveTrackColor: AppColor.grey2,
                          value: prov.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            prov.updateTheme(
                              value ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                        ),
                      );
                    },
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
                border: Border.all(
                  color: isDark ? Color(0xff002678) : AppColor.lightGrey,
                ),
                color: isDark ? AppColor.darkBlue2 : AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: AppStyles.textStyleMedium16(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppAssets.imageArrowRight,
                      color: isDark ? AppColor.dartBlue : AppColor.blue,
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
                border: Border.all(
                  color: isDark ? Color(0xff002678) : AppColor.lightGrey,
                ),
                color: isDark ? AppColor.darkBlue2 : AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                            GoRouter.of(
                              context,
                            ).pushReplacement(AppRouter.logIn);
                            CustomToastWidget.showSuccessToast(
                              "Logout successfully",
                            );
                          },
                          child: Text("Logout"),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      style: AppStyles.textStyleMedium16(
                        color: isDark ? AppColor.white : AppColor.black,
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
