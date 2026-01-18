import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Models/on_boarding_model.dart';
import 'package:flutter/material.dart';

abstract final class AppHelper {
  static List<OnBoardingModel> onBoardingList = [
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

  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 1, color: AppColor.lightGrey),
    );
  }
}
