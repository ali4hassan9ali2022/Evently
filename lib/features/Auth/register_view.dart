import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Core/utils/firebase_helper.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var userPrvider = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: userPrvider.formKeyRegister,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Image.asset(AppAssets.imagesAppLogo),
                  SizedBox(height: size.height * 0.06),
                  Text(
                    "Create your account",
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleSemiBold24(color: AppColor.blue),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    controller: userPrvider.name,
                    keyboardType: TextInputType.name,
                    hintText: "Enter your name",
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
                        AppAssets.imagesIcPerson,
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
                    validator: (value) {
                      final reg = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!reg.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    controller: userPrvider.emailAddressRegister,
                    keyboardType: TextInputType.emailAddress,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 7) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    controller: userPrvider.passwordRegister,
                    keyboardType: TextInputType.visiblePassword,
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
                  SizedBox(height: size.height * 0.02),
                  CustomTextFormField(
                    validator: (value) {
                      if (userPrvider.passwordRegister.text.characters !=
                          userPrvider.passwordConfirm.text.characters) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    controller: userPrvider.passwordConfirm,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Confirm your password",
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
                  SizedBox(height: size.height * 0.064),
                  CustomButton(
                    onTap: () async {
                      if (userPrvider.formKeyRegister.currentState!
                          .validate()) {
                        userPrvider.formKeyRegister.currentState!.save();
                        await userPrvider.cretateAccount(context: context);
                      }
                    },
                    width: double.infinity,
                    borderRadius: 16,
                    height: 48,
                    color: AppColor.blue,
                    child: Center(
                      child: userPrvider.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: AppColor.white,
                              ),
                            )
                          : Text(
                              "Sign up",
                              style: AppStyles.textStyleMedium20(
                                color: AppColor.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.024),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account ? ",
                        style: AppStyles.textStyleRegular14(
                          color: AppColor.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text(
                          "Signup",
                          style: AppStyles.textStyleSemiBold14().copyWith(
                            color: AppColor.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    "Or",
                    style: AppStyles.textStyleMedium16(color: AppColor.blue),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomButton(
                    onTap: () async {
                      await FirebaseHelper.signInWithGoogle();
                    },
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
                          "Sign up with Google",
                          style: AppStyles.textStyleMedium18(
                            color: AppColor.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
