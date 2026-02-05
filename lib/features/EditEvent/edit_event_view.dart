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
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/AddEvent/widget/choose_time_date_widget.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventView extends StatefulWidget {
  const EditEventView({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late CategoryModel selectCategory;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  @override
  void initState() {
    super.initState();
    selectCategory = widget.eventModel.categoryModel;
    selectedDate = widget.eventModel.dateTime;
    selectedTime = TimeOfDay(
      hour: widget.eventModel.dateTime.hour,
      minute: widget.eventModel.dateTime.minute,
    );

    titleController = TextEditingController(text: widget.eventModel.title);
    descriptionController = TextEditingController(
      text: widget.eventModel.description,
    );
  }

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.023),
                      AppBarWidget(title: "Edit event", isDark: isDark),
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
                        isDark: isDark,
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
                          color: isDark ? AppColor.white : AppColor.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01), //! 8
                      CustomTextFormField(
                        controller: titleController,
                        hintText: "Event Title",
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Description ",
                        textAlign: TextAlign.start,
                        style: AppStyles.textStyleMedium16(
                          color: isDark ? AppColor.white : AppColor.black,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01), //! 8
                      CustomTextFormField(
                        controller: descriptionController,
                        hintText: "Event Description....",
                        maxLines: 5,
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseTimeAndDateWidget(
                        isDark: isDark,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        icon: AppAssets.imagesIcCalendar,
                        title: "Event Date",
                        dec: DateFormat('yyyy-MM-dd').format(selectedDate),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ChooseTimeAndDateWidget(
                        isDark: isDark,
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (picked != null) {
                            setState(() {
                              selectedTime = picked;
                            });
                          }
                        },
                        icon: AppAssets.imagesIcTime,
                        title: "Event Time",
                        dec: selectedTime.format(context),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              CustomButton(
                onTap: () async {
                  updateEvent();
                },
                width: double.infinity,
                borderRadius: 16,
                height: 48,
                color: isDark ? AppColor.dartBlue : AppColor.blue,
                child: Center(
                  child: Text(
                    "Update event",
                    style: AppStyles.textStyleMedium20(color: AppColor.white),
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

  updateEvent() async {
    try {
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      CollectionReference event = FirebaseFirestore.instance.collection(
        "events",
      );
      event.doc(widget.eventModel.id).update({
        "title": titleController.text,
        "description": descriptionController.text,
        "dateTime": selectedDate,
        "categoryModel": selectCategory.toJson(),
        "ownerId": widget.eventModel.ownerId,
      });
      CustomToastWidget.showSuccessToast("Event updated successfully");
      GoRouter.of(context).pop();
      GoRouter.of(context).pop();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    }
  }
}
