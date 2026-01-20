import 'dart:developer';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log(eventModel.title);
    return Scaffold(
      backgroundColor: AppColor.offWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: SvgPicture.asset(AppAssets.imagesBack),
                  ),
                  Text(
                    "title",
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleMedium18().copyWith(
                      color: AppColor.black,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.imageEdit),
                      SizedBox(width: 8),
                      SvgPicture.asset(AppAssets.imageDelete),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  eventModel.categoryModel.imagePath,
                  height: MediaQuery.of(context).size.height * .25,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                eventModel.title,
                style: AppStyles.textStyleMedium18(color: AppColor.black),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.offWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(AppAssets.imagesIcCalendar),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${eventModel.dateTime.day} January",
                          style: AppStyles.textStyleMedium16(
                            color: AppColor.black,
                          ),
                        ),
                        Text(
                          "12:12 PM",
                          textAlign: TextAlign.start,
                          style: AppStyles.textStyleMedium16(
                            color: AppColor.grey2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Description",
                textAlign: TextAlign.start,
                style: AppStyles.textStyleMedium16(color: AppColor.black),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  eventModel.description,
                  style: AppStyles.textStyleRegular14(color: AppColor.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
