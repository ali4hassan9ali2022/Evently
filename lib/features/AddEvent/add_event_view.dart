import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/features/AddEvent/widget/choose_time_date_widget.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CategoryModel selectCategory = AppHelper.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.023),
                      AppBarWidget(title: "Add event"),
                      SizedBox(height: size.height * 0.02), //! 16
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          selectCategory.imagePath,
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02), //! 16
                      CategoriesTabBar(
                        category: AppHelper.customCategories,
                        onChanged: (value) {
                          selectCategory = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Title",
                        textAlign: TextAlign.start,
                        style: AppStyles.textStyleMedium16(
                          color: AppColor.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01), //! 8
                      CustomTextFormField(
                        border: AppHelper.outlineInputBorder(),
                        enabledBorder: AppHelper.outlineInputBorder(),
                        focusedBorder: AppHelper.outlineInputBorder(),
                        filled: true,
                        fillColor: AppColor.white,
                        hintText: "Event Title",
                        hintStyle: AppStyles.textStyleRegular14(
                          color: AppColor.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Description ",
                        textAlign: TextAlign.start,
                        style: AppStyles.textStyleMedium16(
                          color: AppColor.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01), //! 8
                      CustomTextFormField(
                        border: AppHelper.outlineInputBorder(),
                        enabledBorder: AppHelper.outlineInputBorder(),
                        focusedBorder: AppHelper.outlineInputBorder(),
                        filled: true,
                        fillColor: AppColor.white,
                        hintText: "Event Description....",
                        maxLines: 5,
                        hintStyle: AppStyles.textStyleRegular14(
                          color: AppColor.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseTimeAndDateWidget(
                        onTap: () async {
                          selectedDate =
                              await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              ) ??
                              selectedDate;
                          setState(() {});
                        },
                        icon: AppAssets.imagesIcCalendar,
                        title: "Event Date",
                        dec: "Choose date",
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseTimeAndDateWidget(
                        onTap: () async {
                          selectedTime =
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ) ??
                              selectedTime;
                          setState(() {});
                        },
                        icon: AppAssets.imagesIcTime,
                        title: "Event Time",
                        dec: "Choose time",
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onTap: () {},
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: AppColor.blue,
                child: Center(
                  child: Text(
                    "Add event",
                    style: AppStyles.textStyleMedium20(),
                  ),
                ),
              ),
              SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}
