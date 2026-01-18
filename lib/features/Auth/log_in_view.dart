import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Image.asset(AppAssets.imagesAppLogo),
              SizedBox(height: size.height * 0.06),
              Text(
                "Login to your account",
                textAlign: TextAlign.start,
                style: AppStyles.textStyleSemiBold24(),
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFormField(
                hintText: "Enter your email",
                hintStyle: AppStyles.textStyleRegular14().copyWith(
                  color: AppColor.grey,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 12,
                    bottom: 12,
                    right: 1.5,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.imagesIcEmail,
                    height: 24,
                    width: 24,
                  ),
                ),
                filled: true,
                fillColor: AppColor.white,
                border: AppHelper.outlineInputBorder(),
                enabledBorder: AppHelper.outlineInputBorder(),
              ),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                hintText: "Enter your password",
                hintStyle: AppStyles.textStyleRegular14().copyWith(
                  color: AppColor.grey,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 12,
                    bottom: 12,
                    right: 1.5,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.imagesIcLock,
                    height: 24,
                    width: 24,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.visibility_off_outlined),
                ),
                filled: true,
                fillColor: AppColor.white,
                border: AppHelper.outlineInputBorder(),
                enabledBorder: AppHelper.outlineInputBorder(),
              ),
              SizedBox(height: size.height * 0.001),
              Text(
                "Forget Password?",
                textAlign: TextAlign.end,

                style: AppStyles.textStyleSemiBold14().copyWith(
                  color: AppColor.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: size.height * 0.06),
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
                  child: Text("Login", style: AppStyles.textStyleMedium20()),
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account ? ",
                    style: AppStyles.textStyleRegular14(),
                  ),
                  Text(
                    " Signup",
                    style: AppStyles.textStyleSemiBold14().copyWith(
                      color: AppColor.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Text(
                "Or",
                style: AppStyles.textStyleMedium16(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                color: AppColor.white,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                borderRadius: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.imagesIcGmail),
                    SizedBox(width: 16),
                    Text(
                      "Login with Google",
                      style: AppStyles.textStyleMedium18(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
