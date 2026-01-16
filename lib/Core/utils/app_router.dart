import 'package:evently/features/OnBoarding/on_boarding_view.dart';
import 'package:evently/features/Splash/splah_view.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static const String onBoarding = "/OnBoardingView";
  static final router = GoRouter(routes: [
    GoRoute(path: "/" , builder: (context, state) => SplahView(),),
    GoRoute(path: onBoarding , builder: (context, state) => OnBoardingView(),)
  ]);
}