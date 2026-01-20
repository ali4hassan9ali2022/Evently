import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.category,
    required this.selectedIndex,
    required this.index,
  });
  final CategoryModel category;
  final int selectedIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;
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
