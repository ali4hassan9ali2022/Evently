import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/features/OnBoarding/Widgets/chanage_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 18),
              Image.asset(AppAssets.imagesAppLogo),

              SizedBox(height: 24),
              Image.asset(AppAssets.imagesBeingCreative, fit: BoxFit.fill),
              SizedBox(height: 24),
              Text(
                "Personalize Your Experience",
                style: AppStyles.textStyleSemiBold20(color: AppColor.black),
              ),
              SizedBox(height: 8),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: AppStyles.textStyleRegular16(color: AppColor.grey),
              ),
              SizedBox(height: 18.5),
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
              SizedBox(height: 16),
              ChangeThemeWidget(
                title: "Theme",
                subtitleOne: Icon(Icons.dark_mode, color: AppColor.white),
                subtitleTwo: Icon(
                  Icons.light_mode_outlined,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.mainOnBoarding);
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: AppColor.blue,
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

  loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? savedTheme = prefs.getBool("isDark");
    if (savedTheme != null) {
      setState(() {
        isDark = savedTheme;
      });
    }
  }

  saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", value);
    setState(() {
      isDark = value;
    });
  }
}
