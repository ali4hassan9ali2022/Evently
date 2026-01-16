import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/features/OnBoarding/Widgets/on_boarding_widget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: AppHelper.onBoardingList.length,
        onPageChanged: (value) {
          currentIndex = value;
          setState(() {});
        },
        itemBuilder: (context, index) => SafeArea(
          child: OnBoardingWidget(
            currentIndex: currentIndex,
            pageController: pageController,
            item: AppHelper.onBoardingList[index],
          ),
        ),
      ),
    );
  }
}


//  Text(
//             "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
//             style: AppStyles.textStyleRegular16(),
//           ),