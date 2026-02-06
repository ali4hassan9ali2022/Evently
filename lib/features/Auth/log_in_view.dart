import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    var userPrvider = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: userPrvider.formKeyLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Image.asset(
                    isDark ? AppAssets.darkLogo : AppAssets.imagesAppLogo,
                  ),
                  SizedBox(height: size.height * 0.06),
                  Text(
                    "Login to your account",
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleSemiBold24(
                      color: isDark ? AppColor.white : AppColor.blue,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomTextFormField(
                    style: TextStyle(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                    controller: userPrvider.emailAddressLogin,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      var rgx = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      );
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!rgx.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    hintText: "Enter your email",
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
                  ),
                  SizedBox(height: size.height * 0.02),
                  CustomTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 7) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                    controller: userPrvider.passwordLogin,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter your password",
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
                    obscureText: userPrvider.isObsecure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        userPrvider.changePasswordVisibility();
                      },
                      icon: Icon(
                        userPrvider.suffix,
                        color: isDark ? AppColor.darkGrey : AppColor.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.001),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.forgetPassword,
                        extra: userPrvider.emailAddressLogin.text.trim(),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      textAlign: TextAlign.end,
                      style: AppStyles.textStyleSemiBold14().copyWith(
                        color: isDark ? AppColor.dartBlue : AppColor.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: isDark
                            ? AppColor.dartBlue
                            : AppColor.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  CustomButton(
                    onTap: () async {
                      if (userPrvider.formKeyLogin.currentState!.validate()) {
                        userPrvider.formKeyLogin.currentState!.save();
                        userPrvider.logIn(context: context);
                      }
                    },
                    width: double.infinity,
                    borderRadius: 16,
                    height: 48,
                    color: isDark ? AppColor.dartBlue : AppColor.blue,
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
                              "Login",
                              style: AppStyles.textStyleMedium20(
                                color: AppColor.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account ? ",
                        style: AppStyles.textStyleRegular14(
                          color: isDark ? AppColor.darkGrey : AppColor.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.register);
                        },
                        child: Text(
                          "Signup",
                          style: AppStyles.textStyleSemiBold14().copyWith(
                            color: isDark ? AppColor.dartBlue : AppColor.blue,
                            decoration: TextDecoration.underline,
                            decorationColor: isDark
                                ? AppColor.dartBlue
                                : AppColor.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    "Or",
                    style: AppStyles.textStyleMedium16(
                      color: isDark ? AppColor.dartBlue : AppColor.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomButton(
                    onTap: () async {
                      await userPrvider.signInWithGoogle(context: context);
                    },
                    color: isDark ? AppColor.darkBlue2 : AppColor.white,
                    border: Border.all(
                      color: isDark ? Color(0xff002678) : AppColor.lightGrey,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    borderRadius: 16,
                    child: userPrvider.isLoadingGoogle
                        ? Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: isDark ? AppColor.white : AppColor.blue,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppAssets.imagesGoolge),
                              SizedBox(width: 16),
                              Text(
                                "Login with Google",
                                style: AppStyles.textStyleMedium18(
                                  color: isDark
                                      ? AppColor.dartBlue
                                      : AppColor.blue,
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
