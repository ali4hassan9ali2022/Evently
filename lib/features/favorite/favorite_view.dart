import 'dart:developer';

import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Favorite_providrer/favorite_provider.dart';
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
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: AppColor.offWhite),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Consumer<FavoriteProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (value.favoriteEvents.isEmpty) {
                return const Center(child: Text("No events found"));
              } else {
                return Column(
                  children: [
                    CustomTextFormField(
                      onChanged: (query) {
                        value.searchFavorite(query: query);
                        log("title = $query");
                        setState(() {});
                      },
                      border: AppHelper.outlineInputBorder(),
                      controller: searchController,
                      enabledBorder: AppHelper.outlineInputBorder(),
                      focusedBorder: AppHelper.outlineInputBorder(),
                      filled: true,
                      fillColor: AppColor.white,
                      hintText: "Search for event",
                      hintStyle: AppStyles.textStyleRegular14(
                        color: AppColor.grey,
                      ),
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.favoriteEvents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRouter.eventDetails,
                                extra: value.favoriteEvents[index],
                              );
                            },
                            child: EventlyWidget(
                              evvent: value.favoriteEvents[index],
                              userModel: Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).userModel!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
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
