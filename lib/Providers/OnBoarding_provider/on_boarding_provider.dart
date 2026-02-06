import 'package:evently/Core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingProvider extends ChangeNotifier {
  PageController pageController = PageController();
  int currentIndex = 0;
  selectOnPageView({required int value}) {
    currentIndex = value;
    notifyListeners();
  }

  saveOnBoardind({required BuildContext context}) async {
    var sharedPre = await SharedPreferences.getInstance();
    sharedPre.setBool("On", true);
    GoRouter.of(context).pushReplacement(AppRouter.logIn);
    notifyListeners();
  }

  
}
