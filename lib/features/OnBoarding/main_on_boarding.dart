import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Providers/OnBoarding_provider/on_boarding_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/OnBoarding/Widgets/on_boarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainOnBoarding extends StatelessWidget {
  const MainOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final isSys = themeProvider.themeMode == ThemeMode.system;
    final onBoardingProvider = Provider.of<OnBoardingProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: onBoardingProvider.pageController,
              itemCount: (isDark || isSys)
                  ? onBoardingProvider.onBoardingListDark.length
                  : onBoardingProvider.onBoardingList.length,
              onPageChanged: (value) {
                onBoardingProvider.selectOnPageView(value: value);
              },
              itemBuilder: (context, index) => OnBoardingWidget(
                currentIndex: onBoardingProvider.currentIndex,
                pageController: onBoardingProvider.pageController,
                item: (isDark || isSys)
                    ? onBoardingProvider.onBoardingListDark[index]
                    : onBoardingProvider.onBoardingList[index],
              ),
            ),
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.4,
              child: SmoothPageIndicator(
                controller: onBoardingProvider.pageController,
                count: (isDark || isSys)
                    ? onBoardingProvider.onBoardingListDark.length
                    : onBoardingProvider.onBoardingList.length,
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
