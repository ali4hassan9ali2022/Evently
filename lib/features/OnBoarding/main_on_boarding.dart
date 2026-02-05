import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Models/on_boarding_model.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/OnBoarding/Widgets/on_boarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainOnBoarding extends StatefulWidget {
  const MainOnBoarding({super.key});

  @override
  State<MainOnBoarding> createState() => _MainOnBoardingState();
}

class _MainOnBoardingState extends State<MainOnBoarding> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: onBoardingList.length,
              onPageChanged: (value) {
                currentIndex = value;
                setState(() {});
              },
              itemBuilder: (context, index) => OnBoardingWidget(
                currentIndex: currentIndex,
                pageController: pageController,
                item: onBoardingList[index],
              ),
            ),
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.4,
              child: SmoothPageIndicator(
                controller: pageController,
                count: onBoardingList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 9,
                  dotColor: isDark ? AppColor.white : AppColor.grey2,
                  activeDotColor: isDark ? AppColor.dartBlue : AppColor.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//  Text(
//             "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
//             style: AppStyles.textStyleRegular16(),
//           ),


