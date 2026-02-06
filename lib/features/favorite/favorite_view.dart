import 'dart:developer';
import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Favorite_providrer/favorite_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fav = Provider.of<FavoriteProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              CustomTextFormField(
                onChanged: (query) {
                  fav.searchFavorite(query: query);
                  log("title = $query");
                  setState(() {});
                },
                border: AppHelper.outlineInputBorder(),
                controller: searchController,
                hintText: context.loc.searchForEvent,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    AppAssets.imagesSearch,
                    width: 24,
                    height: 24,
                    color: AppColor.blue,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02), //! 16
              Consumer<FavoriteProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Expanded(
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (value.filterFavoriteEvents.isEmpty) {
                    return  Center(child: Text(context.loc.noEventsFount));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: value.filterFavoriteEvents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRouter.eventDetails,
                                extra: value.filterFavoriteEvents[index],
                              );
                            },
                            child: EventlyWidget(
                              isDark: isDark,
                              evvent: value.filterFavoriteEvents[index],
                              userModel: Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).userModel!,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getFavorite() {
    Provider.of<FavoriteProvider>(context, listen: false).getFavoriteEvents(
      uid: Provider.of<UserProvider>(context, listen: false).userModel!.userId,
      context: context,
    );
  }
}
