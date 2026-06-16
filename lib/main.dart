import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/event_provider.dart';
import 'services/registration_service.dart';
import 'providers/theme_provider.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';
import 'services/favorite_service.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RegistrationService.loadRegistrations();
  await AuthService.loadUser();
  await NotificationService.init();
  await FavoriteService.loadFavorites();

  runApp(
    MultiProvider(
      providers: [
  ChangeNotifierProvider(create: (_) => EventProvider()),
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
],
      child: const EventHubApp(),
    ),
  );
}

class EventHubApp extends StatelessWidget {
  const EventHubApp({super.key});

  @override
  Widget build(BuildContext context) {
   return Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventHub',

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode:
          themeProvider.isDark
              ? ThemeMode.dark
              : ThemeMode.light,

      home: SplashScreen(),
    );
  },
);
  }
}
