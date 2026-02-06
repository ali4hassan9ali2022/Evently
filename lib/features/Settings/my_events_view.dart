import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Favorite_providrer/favorite_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyEventsView extends StatelessWidget {
  const MyEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.039), //! 32
              Text(
                "My Events",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: isDark ? AppColor.white : AppColor.black,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Consumer<FavoriteProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Expanded(
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (value.filterFavoriteEvents.isEmpty) {
                    return Center(child: Text(context.loc.noEventsFount));
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
}
