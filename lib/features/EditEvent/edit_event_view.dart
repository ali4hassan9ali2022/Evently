import 'package:evently/Core/Widgets/app_bar_widget.dart';
import 'package:evently/Core/Widgets/custom_button.dart';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Event_Provider/update_event_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/AddEvent/widget/choose_time_date_widget.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventView extends StatelessWidget {
  final EventModel eventModel;

  const EditEventView({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = UpdateEventProvider();
        provider.init(eventModel);
        return provider;
      },
      child: Consumer2<UpdateEventProvider, ThemeProvider>(
        builder: (context, update, themeProvider, _) {
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
                            SizedBox(height: size.height * 0.02),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                update.selectCategory.imagePath,
                                height: size.height * .25,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            CategoriesTabBar(
                              isDark: isDark,
                              category: AppHelper.customCategories,
                              onChanged: update.updateCategory,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "Title",
                              style: AppStyles.textStyleMedium16(
                                color: isDark ? AppColor.white : AppColor.black,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextFormField(
                              controller: update.titleController,
                              hintText: "Event Title",
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "Description",
                              style: AppStyles.textStyleMedium16(
                                color: isDark ? AppColor.white : AppColor.black,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextFormField(
                              controller: update.descriptionController,
                              hintText: "Event Description....",
                              maxLines: 5,
                            ),
                            SizedBox(height: size.height * 0.02),
                            ChooseTimeAndDateWidget(
                              isDark: isDark,
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: update.selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                if (picked != null) update.updateDate(picked);
                              },
                              icon: AppAssets.imagesIcCalendar,
                              title: "Event Date",
                              dec: DateFormat(
                                'yyyy-MM-dd',
                              ).format(update.selectedDate),
                            ),
                            SizedBox(height: size.height * 0.02),
                            ChooseTimeAndDateWidget(
                              isDark: isDark,
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: update.selectedTime,
                                );
                                if (picked != null) update.updateTime(picked);
                              },
                              icon: AppAssets.imagesIcTime,
                              title: "Event Time",
                              dec: update.selectedTime.format(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    CustomButton(
                      onTap: () => update.updateEvent(
                        id: eventModel.id,
                        ownerId: eventModel.ownerId,
                        context: context,
                      ),
                      width: double.infinity,
                      borderRadius: 16,
                      height: 48,
                      color: isDark ? AppColor.dartBlue : AppColor.blue,
                      child: Center(
                        child: update.isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColor.white,
                                ),
                              )
                            : Text(
                                "Update event",
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
        },
      ),
    );
  }
}
