import 'dart:developer';

import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/Providers/Language_provider/language_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final langProvider = Provider.of<LanguageProvider>(context);
    final currentLang = langProvider.lang.languageCode;
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
                      context.loc.welcomeBack,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 4),
                    Text(
                      Provider.of<UserProvider>(context).userModel!.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        var dark = themeProvider.updateTheme(
                          isDark ? ThemeMode.light : ThemeMode.dark,
                        );
                        log("Dark: $dark");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        if (currentLang == "en") {
                          langProvider.saveLanguage("ar");
                        } else {
                          langProvider.saveLanguage("en");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isDark ? AppColor.dartBlue : AppColor.blue,
                        ),
                        child: Text(
                          currentLang == "en" ? "AR" : "EN",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),

            CategoriesTabBar(
              isDark: isDark,
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
                    return Center(child: Text(context.loc.noEventsFount));
                  } else {
                    return EventlyListView(
                      isDark: isDark,
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
