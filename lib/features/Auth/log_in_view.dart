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

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> fromKey = GlobalKey();
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
            child: Form(
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Image.asset(AppAssets.imagesAppLogo),
                  SizedBox(height: size.height * 0.06),
                  Text(
                    "Login to your account",
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleSemiBold24(color: AppColor.blue),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomTextFormField(
                    controller: emailAddress,
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
                    hintStyle: AppStyles.textStyleRegular14(
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
                      } else if (value.length < 7) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter your password",
                    hintStyle: AppStyles.textStyleRegular14(
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
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.forgetPassword);
                    },
                    child: Text(
                      "Forget Password?",
                      textAlign: TextAlign.end,
                      style: AppStyles.textStyleSemiBold14().copyWith(
                        color: AppColor.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  CustomButton(
                    onTap: () async {
                      if (fromKey.currentState!.validate()) {
                        fromKey.currentState!.save();
                        logIn();
                      }
                    },
                    width: double.infinity,
                    borderRadius: 16,
                    height: 48,
                    color: AppColor.blue,
                    child: Center(
                      child: isLoading
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
                          color: AppColor.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.register);
                        },
                        child: Text(
                          "Signup",
                          style: AppStyles.textStyleSemiBold14().copyWith(
                            color: AppColor.blue,
                            decoration: TextDecoration.underline,
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
                          "Login with Google",
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

  logIn() async {
    try {
      isLoading = true;
      setState(() {});
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.text.trim(),
        password: password.text.trim(),
      );
      UserModel.currentUser = await getUser(userId: credential.user!.uid);
      if (!mounted) return;
      GoRouter.of(context).pushReplacement(AppRouter.mainView);
      CustomToastWidget.showSuccessToast("Login successfully");
    } on FirebaseAuthException catch (e) {
      CustomToastWidget.showErrorToast(e.message ?? "Auth error");
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  Future<UserModel> getUser({required String userId}) async {
    var user = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot snapshot = await user.doc(userId).get();
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    UserModel userModel = UserModel.fromJson(json);
    return userModel;
  }
}
