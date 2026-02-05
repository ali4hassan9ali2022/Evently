import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/OnBoarding/Widgets/chanage_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.02),
              Image.asset(
                isDark ? AppAssets.darkLogo : AppAssets.imagesAppLogo,
              ),

              SizedBox(height: size.height * 0.03),
              Image.asset(
                isDark
                    ? AppAssets.darkOnBoarding
                    : AppAssets.imagesBeingCreative,
                fit: BoxFit.fill,
                height: size.height * 0.43,
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Personalize Your Experience",
                style: AppStyles.textStyleSemiBold20(
                  color: isDark ? AppColor.white : AppColor.black,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: AppStyles.textStyleRegular16(
                  color: isDark ? AppColor.darkGrey : AppColor.grey,
                ),
              ),
              SizedBox(height: size.height * 0.023),
              ChangeLanguageWidget(
                title: "Language",
                subtitleOne: Text(
                  "English",
                  style: AppStyles.textStyleSemiBold14(color: AppColor.white),
                ),
                subtitleTwo: Text(
                  "Arabic",
                  style: AppStyles.textStyleSemiBold14(color: AppColor.blue),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ChangeThemeWidget(title: "Theme"),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.mainOnBoarding);
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: isDark ? AppColor.dartBlue : AppColor.blue,
                child: Center(
                  child: Text(
                    "Let’s start",
                    style: AppStyles.textStyleMedium20(color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? savedTheme = prefs.getBool("isDark");
//     if (savedTheme != null) {
//       setState(() {
//         isDark = savedTheme;
//       });
//     }
//   }

//   saveTheme(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("isDark", value);
//     setState(() {
//       isDark = value;
//     });
//   }