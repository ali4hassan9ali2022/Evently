import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/features/Home/Widgets/categories_tab_bar.dart';
import 'package:evently/features/Home/Widgets/evently_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fetchProvider = Provider.of<FetchEventProvider>(context);

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
                      Provider.of<UserProvider>(context).userModel!.name,
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
                fetchProvider.setSelectedCategory(value);
              },
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: Consumer<FetchEventProvider>(
                builder: (context, value, _) {
                  if (value.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (value.filteredEvents.isEmpty) {
                    return const Center(child: Text("No events found"));
                  } else {
                    return EventlyListView(
                      userModel: Provider.of<UserProvider>(context).userModel!,
                      evvent: value.filteredEvents,
                      itemCount: value.filteredEvents.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
