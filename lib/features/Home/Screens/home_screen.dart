import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Core/utils/firebase_helper.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:evently/features/Home/Widgets/evently_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedCategory = AppHelper.allCategories[0];
  List<EventModel> filteredEvents = [];
  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03), //! 24
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome Back ✨",
                      style: AppStyles.textStyleRegular14(),
                    ),
                    SizedBox(height: 4),
                    Text(
                      UserModel.currentUser!.name,
                      textAlign: TextAlign.left,
                      style: AppStyles.textStyleMedium20().copyWith(
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.imagesSun,
                        color: AppColor.blue,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.blue,
                      ),
                      child: Text(
                        "EN",
                        style: AppStyles.textStyleSemiBold14().copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            CategoriesTabBar(
              category: AppHelper.allCategories,
              onChanged: (value) {
                selectedCategory = value;
                if (selectedCategory != AppHelper.all) {
                  filteredEvents = FirebaseHelper.events.where((element) {
                    return element.categoryModel.name == selectedCategory.name;
                  }).toList();
                } else {
                  filteredEvents = FirebaseHelper.events;
                }
                setState(() {});
              },
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(child: EventlyListView(
              evvent: filteredEvents,
              itemCount: filteredEvents.length,
            )),
          ],
        ),
      ),
    );
  }

  Future<void> loadEvents() async {
    await FirebaseHelper.getEvents();
    filteredEvents = FirebaseHelper.events;
    setState(() {});
  }
}
