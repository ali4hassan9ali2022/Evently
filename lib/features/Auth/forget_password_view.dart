import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.023),
              AppBarWidget(title: "Forget Password", isDark: isDark),
              SizedBox(height: size.height * 0.08),
              Image.asset(AppAssets.imagesForgetPassword, fit: BoxFit.fill),
              SizedBox(height: size.height * 0.05),
              CustomButton(
                onTap: () {
                  // GoRouter.of(
                  //   context,
                  // ).pushReplacement(AppRouter.mainOnBoarding);
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: AppColor.blue,
                child: Center(
                  child: Text(
                    "Reset password",
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
