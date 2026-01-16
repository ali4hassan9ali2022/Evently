import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ChangeWidget extends StatelessWidget {
  const ChangeWidget({super.key, required this.title, required this.subtitleOne, required this.subtitleTwo});
  final String title;
  final Widget subtitleOne;
  final Widget subtitleTwo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppStyles.textStyleMedium18()),
        Spacer(),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.blue,
              ),
              child: subtitleOne,
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.lightGrey,
              ),
              child: subtitleTwo,
            ),
          ],
        ),
      ],
    );
  }
}
