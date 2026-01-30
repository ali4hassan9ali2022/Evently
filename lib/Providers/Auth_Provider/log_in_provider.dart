import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogInProvider extends ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> fromKey = GlobalKey();
  UserModel? userModel;
  logIn({required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress.text.trim(),
        password: password.text.trim(),
      );
      userModel = await getUser(userId: credential.user!.uid);
      GoRouter.of(context).pushReplacement(AppRouter.mainView);
      log("Login successfully");
      CustomToastWidget.showSuccessToast("Login successfully");
    } on FirebaseAuthException catch (e) {
      CustomToastWidget.showErrorToast(e.message ?? "Auth error");
      log("Login failed by FirebaseAuthException");
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
      log("Login failed by catch");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserModel> getUser({required String userId}) async {
    var user = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot snapshot = await user.doc(userId).get();
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    userModel = UserModel.fromJson(json);
    return userModel!;
  }
}