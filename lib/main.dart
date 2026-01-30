import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/add_event_providr.dart';
import 'package:evently/Providers/Event_Provider/delete_event_provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:evently/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Evently",
        routerConfig: AppRouter.router,
      ),
    );
  }
}
