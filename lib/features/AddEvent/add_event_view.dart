import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/features/AddEvent/widget/choose_time_date_widget.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  CategoryModel selectCategory = AppHelper.customCategories[0];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
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
                        controller: titleController,
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
                        controller: descriptionController,
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
                        dec: selectedDate == null
                            ? "Choose date"
                            : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
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
                        dec: selectedTime == null
                            ? "Choose time"
                            : selectedTime!.format(context),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onTap: () async {
                  createEvent();
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: AppColor.blue,
                child: Center(
                  child: isLoading
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

  createEvent() {
    try {
      selectedDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      isLoading = true;
      setState(() {});
      CollectionReference events = FirebaseFirestore.instance.collection(
        "events",
      );

      DocumentReference docu = events.doc();
      EventModel eventModel = EventModel(
        id: docu.id,
        ownerId: UserModel.currentUser!.userId,
        categoryModel: selectCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate!,
      );

      docu.set(eventModel.toJson());
      CustomToastWidget.showSuccessToast("Event added successfully");
      isLoading = false;
      setState(() {});
      GoRouter.of(context).pop();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    } finally {
      isLoading = false;
      setState(() {});
    }
  }
}
