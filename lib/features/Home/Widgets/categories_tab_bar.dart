import 'package:evently/Models/category_model.dart';
import 'package:evently/features/Home/Widgets/category_widget.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  const CategoriesTabBar({super.key, required this.onChanged, required this.category});
  final Function(CategoryModel) onChanged;
  final List<CategoryModel> category;
  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.category.length,
      child: TabBar(
        labelPadding: EdgeInsets.only(right: 8),
        dividerColor: Colors.transparent,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged(widget.category[index]);
          setState(() {});
        },
        tabs: List.generate(widget.category.length, (index) {
          return CategoryWidget(
            category: widget.category[index],
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