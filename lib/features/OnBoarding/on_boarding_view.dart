import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/features/OnBoarding/Widgets/chanage_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

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
                style: AppStyles.textStyleSemiBold20(),
              ),
              SizedBox(height: 8),
              Text(
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                style: AppStyles.textStyleRegular16(),
              ),
              SizedBox(height: 18.5),
              ChangeWidget(
                title: "Language",
                subtitleOne: Text(
                  "English",
                  style: AppStyles.textStyleSemiBold14().copyWith(
                    color: AppColor.white,
                  ),
                ),
                subtitleTwo: Text(
                  "Arabic",
                  style: AppStyles.textStyleSemiBold14(),
                ),
              ),
              SizedBox(height: 16),
              ChangeWidget(
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
                    style: AppStyles.textStyleMedium20(),
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
