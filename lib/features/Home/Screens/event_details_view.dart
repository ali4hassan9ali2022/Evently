import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/delete_event_provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final userId = Provider.of<UserProvider>(
      context,
      listen: false,
    ).userModel!.userId;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Consumer<FetchEventProvider>(
      builder: (context, fetchProvider, _) {
        final updatedEvent = fetchProvider.events.firstWhere(
          (event) => event.id == eventModel.id,
          orElse: () => eventModel,
        );

        var time = DateFormat('h:mm a').format(updatedEvent.dateTime);
        bool isOwner = userId == updatedEvent.ownerId;

        return Scaffold(
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
                      IconButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? AppColor.darkBlue2
                              : AppColor.offWhite,
                        ),
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: isDark ? AppColor.white : AppColor.blue,
                        ),
                      ),
                      Text(
                        context.loc.eventDetails,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyleMedium18().copyWith(
                          color: isDark ? AppColor.white : AppColor.black,
                        ),
                      ),
                      if (isOwner)
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                GoRouter.of(context).push(
                                  AppRouter.editEvent,
                                  extra: updatedEvent,
                                );
                              },
                              child: SvgPicture.asset(AppAssets.imageEdit),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(context.loc.delete),
                                    content: Text(
                                      context.loc.deleteSure,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(context.loc.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Provider.of<DeleteEventProvider>(
                                            context,
                                            listen: false,
                                          ).deleteEvent(
                                            context: context,
                                            eventModel: updatedEvent,
                                          );
                                        },
                                        child: Text(context.loc.ok),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: SvgPicture.asset(AppAssets.imageDelete),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      updatedEvent.categoryModel.getImagePath(isDark),
                      height: MediaQuery.of(context).size.height * .25,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    updatedEvent.title,
                    style: AppStyles.textStyleMedium18(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColor.darkBlue2 : AppColor.offWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColor.dartBlue : AppColor.lightGrey,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? AppColor.dartBlue
                                  : AppColor.lightGrey,
                            ),
                            color: isDark
                                ? AppColor.darkBlue2
                                : AppColor.offWhite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            AppAssets.imagesIcCalendar,
                            color: isDark
                                ? AppColor.dartBlue
                                : AppColor.darkBlue,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${updatedEvent.dateTime.day} ${DateFormat('MMMM').format(updatedEvent.dateTime)}", // 🔥
                              style: AppStyles.textStyleMedium16(
                                color: isDark ? AppColor.white : AppColor.black,
                              ),
                            ),
                            Text(
                              time,
                              textAlign: TextAlign.start,
                              style: AppStyles.textStyleMedium16(
                                color: isDark
                                    ? AppColor.darkGrey
                                    : AppColor.grey2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    context.loc.description,
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleMedium16(
                      color: isDark ? AppColor.white : AppColor.black,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? AppColor.dartBlue : AppColor.lightGrey,
                      ),
                      color: isDark ? AppColor.darkBlue2 : AppColor.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      updatedEvent.description,
                      style: AppStyles.textStyleRegular14(
                        color: isDark ? AppColor.white : AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
