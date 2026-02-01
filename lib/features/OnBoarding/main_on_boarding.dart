import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/features/OnBoarding/Widgets/on_boarding_widget.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: AppHelper.onBoardingList.length,
              onPageChanged: (value) {
                currentIndex = value;
                setState(() {});
              },
              itemBuilder: (context, index) => OnBoardingWidget(
                currentIndex: currentIndex,
                pageController: pageController,
                item: AppHelper.onBoardingList[index],
              ),
            ),
            Positioned(
              top: size.height * 0.49,
              left: size.width * 0.4,
              child: SmoothPageIndicator(
                controller: pageController,
                count: AppHelper.onBoardingList.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 9,
                  dotColor: AppColor.grey2,
                  activeDotColor: AppColor.blue,
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


