import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplahView extends StatefulWidget {
  const SplahView({super.key});

  @override
  State<SplahView> createState() => _SplahViewState();
}

class _SplahViewState extends State<SplahView> {
  @override
  void initState() {
    super.initState();
    navgigat();
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

  navgigat() async {
    var sharedPrf = await SharedPreferences.getInstance();
    bool? onBoardingCompleted = sharedPrf.getBool("On");
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(seconds: 3));
    if (user != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.userModel = await userProvider.getUser(userId: user.uid);
      GoRouter.of(context).pushReplacement(AppRouter.mainView);
    } else {
      if (onBoardingCompleted != null && onBoardingCompleted) {
        GoRouter.of(context).pushReplacement(AppRouter.logIn);
      } else {
        GoRouter.of(context).pushReplacement(AppRouter.onBoarding);
      }
    }
  }
}
