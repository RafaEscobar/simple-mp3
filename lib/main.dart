import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/routes/app_route.dart';
import 'package:simple_mp3/screens/load_screen.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider(),)
      ],
      builder: (_, __) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const LoadScreen(),
          routes: AppRoute.routes,
        );
      },
    );
  }
}