import 'package:evently/Core/Widgets/custom_text_form_field.dart';
import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/features/Home/Widgets/evently_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: AppColor.offWhite),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                  border: AppHelper.outlineInputBorder(),
                  enabledBorder: AppHelper.outlineInputBorder(),
                  focusedBorder: AppHelper.outlineInputBorder(),
                  filled: true,
                  fillColor: AppColor.white,
                  hintText: "Search for event",
                  hintStyle: AppStyles.textStyleRegular14(color: AppColor.grey),
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
                EventlyListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
