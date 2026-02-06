import 'package:evently/Core/Theme/theme_app.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/add_event_providr.dart';
import 'package:evently/Providers/Event_Provider/delete_event_provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/Providers/Favorite_providrer/favorite_provider.dart';
import 'package:evently/Providers/Language_provider/language_provider.dart';
import 'package:evently/Providers/OnBoarding_provider/on_boarding_provider.dart';
import 'package:evently/Providers/Theme_Provider/theme_provider.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
          create: (context) => FetchEventProvider()..getEvents(),
        ),
        ChangeNotifierProvider(create: (context) => AddEventProvidr()),
        ChangeNotifierProvider(create: (context) => DeleteEventProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themm, lan, child) {
          return MaterialApp.router(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('ar')],
            locale: lan.lang,
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,
            themeMode: themm.themeMode,
            debugShowCheckedModeBanner: false,
            title: "Evently",
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
