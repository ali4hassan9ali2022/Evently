import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Models/on_boarding_model.dart';
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

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: AppAssets.imagesHotTrending,
      title: "Find Events That Inspire You",
      subTitle:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnBoardingModel(
      image: AppAssets.imagesBeingCreative1,
      title: "Effortless Event Planning",
      subTitle:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnBoardingModel(
      image: AppAssets.imagesBeingCreative2,
      title: "Connect with Friends & Share Moments",
      subTitle:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];
  List<OnBoardingModel> onBoardingListDark = [
    OnBoardingModel(
      image: AppAssets.darkOnBoardingOne,
      title: "Find Events That Inspire You",
      subTitle:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnBoardingModel(
      image: AppAssets.darkOnBoardingTwo,
      title: "Effortless Event Planning",
      subTitle:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnBoardingModel(
      image: AppAssets.darkOnBoardingThree,
      title: "Connect with Friends & Share Moments",
      subTitle:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];
}
