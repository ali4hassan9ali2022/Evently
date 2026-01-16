import 'package:evently/features/Auth/log_in_view.dart';
import 'package:evently/features/OnBoarding/main_on_boarding.dart';
import 'package:evently/features/OnBoarding/on_boarding_view.dart';
import 'package:evently/features/Splash/splah_view.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static const String onBoarding = "/OnBoardingView";
  static const String mainOnBoarding = "/mainOnBoarding";
  static const String logIn = "/LogIn";
  static final router = GoRouter(routes: [
    GoRoute(path: "/" , builder: (context, state) => SplahView(),),
    GoRoute(path: onBoarding , builder: (context, state) => OnBoardingView(),),
    GoRoute(path: mainOnBoarding , builder: (context, state) => MainOnBoarding(),),
    GoRoute(path: logIn , builder: (context, state) => LogInView(),),
  ]);
}