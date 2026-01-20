import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.onChanged,
  });
  final List<CategoryModel> categories;
  final Function(CategoryModel) onChanged;
  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        dividerColor: Colors.transparent,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged(widget.categories[index]);
          setState(() {});
        },
        tabs: widget.categories.map(mapCategoryToWidget).toList(),
      ),
    );
  }

  Widget mapCategoryToWidget(CategoryModel category) {
    bool isSelected = selectedIndex == widget.categories.indexOf(category);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.blue : AppColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            category.icon,
            color: isSelected ? AppColor.white : AppColor.blue,
          ),
          SizedBox(width: 8),
          Text(
            category.name,
            style: AppStyles.textStyleMedium18().copyWith(
              color: isSelected ? AppColor.white : AppColor.blue,
            ),
          ),
        ],
      ),
    );
  }
}