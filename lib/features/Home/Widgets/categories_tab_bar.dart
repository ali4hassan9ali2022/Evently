import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/features/Home/Widgets/category_widget.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  const CategoriesTabBar({super.key, required this.onChanged});
  final Function(CategoryModel) onChanged;
  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppHelper.categories.length,
      child: TabBar(
        dividerColor: Colors.transparent,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged(AppHelper.categories[index]);
          setState(() {});
        },
        tabs: List.generate(AppHelper.categories.length, (index) {
          return CategoryWidget(
            category: AppHelper.categories[index],
            selectedIndex: selectedIndex,
            index: index,
          );
        }),
      ),
    );
  }
}




//  AppHelper.categories.map((category) {
//           return CategoryItem(category: category, selectedIndex: selectedIndex);
//         }).toList(),