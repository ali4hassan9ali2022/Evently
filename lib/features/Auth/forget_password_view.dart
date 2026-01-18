import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.023),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: SvgPicture.asset(AppAssets.imagesBack),
                  ),
                  Expanded(
                    child: Text(
                      "Forget Password",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleMedium18().copyWith(
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
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
