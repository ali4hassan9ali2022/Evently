import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Row(
      children: [
        Text(
          title,
          style: AppStyles.textStyleMedium18(
            color: isDark ? AppColor.white : AppColor.blue,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                themeProvider.updateTheme(ThemeMode.light);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !isDark ? AppColor.blue : Color(0xff001440),
                ),
                child: Icon(Icons.light_mode_outlined, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                themeProvider.updateTheme(ThemeMode.dark);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isDark ? AppColor.dartBlue : AppColor.white,
                ),
                child: Icon(
                  Icons.dark_mode_outlined,
                  color: isDark ? AppColor.offWhite : AppColor.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
    required this.title,
    required this.subtitleOne,
    required this.subtitleTwo,
  });
  final String title;
  final Widget subtitleOne;
  final Widget subtitleTwo;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.textStyleMedium18(
            color: isDark ? AppColor.white : AppColor.blue,
          ),
        ),
        Spacer(),
        Row(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.blue,
                ),
                child: subtitleOne,
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.lightGrey,
                ),
                child: subtitleTwo,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
