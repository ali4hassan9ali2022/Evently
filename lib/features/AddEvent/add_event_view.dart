import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Event_Provider/add_event_providr.dart';
import 'package:evently/features/AddEvent/widget/choose_time_date_widget.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var addEventProvidr = Provider.of<AddEventProvidr>(context);
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
                          addEventProvidr.selectCategory.imagePath,
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02), //! 16
                      CategoriesTabBar(
                        category: AppHelper.customCategories,
                        onChanged: (value) {
                          addEventProvidr.setSelectedCategory(value);
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
                        controller: addEventProvidr.titleController,
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
                        controller: addEventProvidr.descriptionController,
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
                          addEventProvidr.selectData(context: context);
                        },
                        icon: AppAssets.imagesIcCalendar,
                        title: "Event Date",
                        dec: addEventProvidr.selectedDate == null
                            ? "Choose date"
                            : "${addEventProvidr.selectedDate!.year}-${addEventProvidr.selectedDate!.month}-${addEventProvidr.selectedDate!.day}",
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseTimeAndDateWidget(
                        onTap: () async {
                          addEventProvidr.selectTime(context: context);
                        },
                        icon: AppAssets.imagesIcTime,
                        title: "Event Time",
                        dec: addEventProvidr.selectedTime == null
                            ? "Choose time"
                            : addEventProvidr.selectedTime!.format(context),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onTap: () async {
                  await addEventProvidr.createEvent(context: context);
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: AppColor.blue,
                child: Center(
                  child: addEventProvidr.isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,

                          child: CircularProgressIndicator(
                            color: AppColor.white,
                          ),
                        )
                      : Text(
                          "Add event",
                          style: AppStyles.textStyleMedium20(
                            color: AppColor.white,
                          ),
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
