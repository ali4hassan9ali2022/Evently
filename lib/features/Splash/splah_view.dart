import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});

  @override
  State<SplahView> createState() => _SplahViewState();
}

class _SplahViewState extends State<SplahView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      GoRouter.of(context).push(AppRouter.onBoarding);
    },);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height * 0.41),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Image.asset(
              AppAssets.imagesAppLogo,
              height: 58,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: size.height * 0.32),
          Image.asset(AppAssets.imagesRoute),
          SizedBox(height: 8),
          Text(
            "Supervised by Mohamed Nabil",
            style: AppStyles.textStyleRegular14(),
          ),
        ],
      ),
    );
  }
}
