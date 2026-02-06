import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  //! Register
  TextEditingController name = TextEditingController();
  TextEditingController emailAddressRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();
  TextEditingController passwordConfirm = TextEditingController();
  //! Login
  TextEditingController emailAddressLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  bool isLoading = false;
  UserModel? userModel;
  //! Create Account in Firebase Auth
  cretateAccount({required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddressRegister.text,
            password: passwordRegister.text,
          );
      log(credential.user!.uid);
      userModel = UserModel(
        userId: credential.user!.uid,
        name: name.text,
        email: emailAddressRegister.text,
      );
      await addUser(userModel: userModel!);
      log(UserModel.currentUser.toString());
      await GoRouter.of(context).pushReplacement(AppRouter.mainView);
      log("Register successfully");
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
      log("Error $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //! Create User in Firebase Store
  addUser({required UserModel userModel}) async {
    final user = FirebaseFirestore.instance.collection("user");

    user.doc(userModel.userId).set(userModel.toJson());
    notifyListeners();
  }

  //! Log In
  logIn({required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddressLogin.text.trim(),
        password: passwordLogin.text.trim(),
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

  //! Get User From Firebase Store
  Future<UserModel> getUser({required String userId}) async {
    var user = FirebaseFirestore.instance.collection('user');
    DocumentSnapshot snapshot = await user.doc(userId).get();

    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception("User data not found in Firestore");
    }

    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

    UserModel userModel = UserModel.fromJson(json);
    return userModel;
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isObsecure = true;
  void changePasswordVisibility() {
    isObsecure = !isObsecure;

    suffix = isObsecure
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    notifyListeners();
  }

  IconData suffixOne = Icons.visibility_off_outlined;
  bool isObsecureOne = true;
  void changePasswordVisibilityOne() {
    isObsecureOne = !isObsecureOne;

    suffixOne = isObsecureOne
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    notifyListeners();
  }

  //! Reset Password
  Future<void> resetPassword(String email) async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomToastWidget.showSuccessToast(
        "If this email exists, a reset link has been sent",
      );
      log("If this email exists, a reset link has been sent");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomToastWidget.showErrorToast("No user found for that email.");
        log("No user found for that email.");
      }
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isLoadingGoogle = false;
  //! Sign With Google
  Future<void> signInWithGoogle({required BuildContext context}) async {
    if (isLoadingGoogle) {
      CustomToastWidget.showErrorToast(
        "Google sign-in is already in progress.",
      );
      return;
    }

    isLoadingGoogle = true;
    notifyListeners();

    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        CustomToastWidget.showErrorToast("Google sign-in was cancelled.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final userRef = FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user!.uid);

      final doc = await userRef.get();

      if (!doc.exists) {
        userModel = UserModel(
          userId: userCredential.user!.uid,
          name: googleUser.displayName ?? '',
          email: googleUser.email,
          photoUrl: googleUser.photoUrl ?? '',
        );

        await addUser(userModel: userModel!);
      }

      userModel = await getUser(userId: userCredential.user!.uid);

      GoRouter.of(context).pushReplacement(AppRouter.mainView);
      CustomToastWidget.showSuccessToast("Google sign-in successful.");
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
      log(e.toString());
    } finally {
      isLoadingGoogle = false;
      notifyListeners();
    }
  }
}
