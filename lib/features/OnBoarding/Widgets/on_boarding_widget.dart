import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.item,
    required this.pageController,
    required this.currentIndex,
  });
  final OnBoardingModel item;
  final PageController pageController;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentIndex != 0
                  ? IconButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    )
                  : SizedBox(width: 50, height: 50),
              Image.asset(AppAssets.imagesAppLogo),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushReplacement(AppRouter.logIn);
                },
                child: Text("Skip", style: AppStyles.textStyleSemiBold14()),
              ),
            ],
          ),
          SizedBox(height: 24),
          Image.asset(item.image, fit: BoxFit.fill),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
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
          SizedBox(height: 16),
          Text(item.title, style: AppStyles.textStyleSemiBold20()),
          SizedBox(height: 8),
          Text(item.subTitle, style: AppStyles.textStyleRegular16()),
          Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {
              if (currentIndex < AppHelper.onBoardingList.length - 1) {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                GoRouter.of(context).pushReplacement(AppRouter.logIn);
              }
            },
            width: double.infinity,
            height: 48,
            borderRadius: 16,
            color: AppColor.blue,
            child: Center(
              child: currentIndex == AppHelper.onBoardingList.length - 1
                  ? Text("Get Started", style: AppStyles.textStyleMedium20())
                  : Text("Next", style: AppStyles.textStyleMedium20()),
            ),
          ),
        ],
      ),
    );
  }
}
