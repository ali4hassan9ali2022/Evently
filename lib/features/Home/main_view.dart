import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/features/Home/Widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
      body: AppHelper.pages[currentIndex],
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColor.blue,
      onPressed: () {
        GoRouter.of(context).push(AppRouter.addEventlyView);
      },
      shape: CircleBorder(),
      child: Icon(Icons.add, color: AppColor.white),
    );
  }
}
