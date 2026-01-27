import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController name = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
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
                  controller: name,
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
                  controller: emailAddress,
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
                  controller: password,
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
                  controller: passwordConfirm,
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
                    await cretateAccount();
                  },
                  width: double.infinity,
                  borderRadius: 16,
                  height: 48,
                  color: AppColor.blue,
                  child: Center(
                    child: Text(
                      "Sign up",
                      style: AppStyles.textStyleMedium20(color: AppColor.white),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account ? ",
                      style: AppStyles.textStyleRegular14(color: AppColor.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: const CircularProgressIndicator(
                                color: AppColor.white,
                              ),
                            )
                          : Text(
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
    );
  }

  cretateAccount() async {
    try {
      isLoading = true;
      setState(() {});
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress.text,
            password: password.text,
          );
      log(credential.user!.uid);
      UserModel.currentUser = UserModel(
        userId: credential.user!.uid,
        name: name.text,
        email: emailAddress.text,
      );
      await addUser(userModel: UserModel.currentUser!);
      log(UserModel.currentUser.toString());
      await GoRouter.of(context).pushReplacement(AppRouter.mainView);
      CustomToastWidget.showSuccessToast("Register successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomToastWidget.showErrorToast("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        CustomToastWidget.showErrorToast(
          "The account already exists for that email.",
        );
      } else {
        CustomToastWidget.showErrorToast("Something went wrong.");
      }
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}

addUser({required UserModel userModel}) async {
  final user = FirebaseFirestore.instance.collection("user");

  user.doc(userModel.userId).set(userModel.toJson());
}
