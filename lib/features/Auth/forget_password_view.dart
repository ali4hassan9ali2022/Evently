import 'dart:developer';

import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key, required this.email});
  final String email;

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    log("Your email: ${emailController.text}");
    var resetPassword = Provider.of<UserProvider>(context);
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
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  return CustomButton(
                    onTap: () {
                      final email = emailController.text.trim();
                      if (email.isEmpty) {
                        CustomToastWidget.showErrorToast(
                          "Please enter your email",
                        );
                        return;
                      }
                      value.resetPassword(email);
                    },
                    width: double.infinity,
                    borderRadius: 16,
                    height: 48,
                    color: AppColor.blue,
                    child: Center(
                      child: value.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColor.white,
                              ),
                            )
                          : Text(
                              "Reset password",
                              style: AppStyles.textStyleMedium20(
                                color: AppColor.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
