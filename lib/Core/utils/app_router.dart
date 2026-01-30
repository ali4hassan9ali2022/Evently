import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Auth_Provider/log_in_provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/features/AddEvent/add_event_view.dart';
import 'package:evently/features/Auth/forget_password_view.dart';
import 'package:evently/features/Auth/log_in_view.dart';
import 'package:evently/features/Auth/register_view.dart';
import 'package:evently/features/EditEvent/edit_event_view.dart';
import 'package:evently/features/Home/Screens/event_details_view.dart';
import 'package:evently/features/Home/main_view.dart';
import 'package:evently/features/OnBoarding/main_on_boarding.dart';
import 'package:evently/features/OnBoarding/on_boarding_view.dart';
import 'package:evently/features/Splash/splah_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract final class AppRouter {
  static const String onBoarding = "/OnBoardingView";
  static const String mainOnBoarding = "/mainOnBoarding";
  static const String logIn = "/LogIn";
  static const String register = "/RegisterView";
  static const String forgetPassword = "/ForgetPasswordView";
  static const String mainView = "/MainView";
  static const String addEventlyView = "/AddEventlyView";
  static const String eventDetails = "/EventDetailsView";
  static const String editEvent = "/EditEventView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SplahView()),
      GoRoute(path: onBoarding, builder: (context, state) => OnBoardingView()),
      GoRoute(
        path: mainOnBoarding,
        builder: (context, state) => MainOnBoarding(),
      ),
      GoRoute(
        path: logIn,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => LogInProvider(),
          child: LogInView(),
        ),
      ),
      GoRoute(path: register, builder: (context, state) => RegisterView()),
      GoRoute(
        path: forgetPassword,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: mainView,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => LogInProvider(),
          child: ChangeNotifierProvider(
            create: (context) => FetchEventProvider()..getEvents(),
            child: MainView(),
          ),
        ),
      ),
      GoRoute(
        path: addEventlyView,
        builder: (context, state) => AddEventView(),
      ),
      GoRoute(
        path: eventDetails,
        builder: (context, state) {
          final eventModel = state.extra as EventModel?;
          if (eventModel == null) {
            return const Scaffold(body: Center(child: Text('No Event Data')));
          }
          return EventDetailsView(eventModel: eventModel);
        },
      ),
      GoRoute(
        path: editEvent,
        builder: (context, state) {
          final eventModel = state.extra as EventModel?;
          if (eventModel == null) {
            return const Scaffold(body: Center(child: Text('No Event Data')));
          }
          return EditEventView(eventModel: eventModel);
        },
      ),
    ],
  );
}
