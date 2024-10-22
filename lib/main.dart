import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/routes/app_route.dart';
import 'package:simple_mp3/services/preferences_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider(),)
      ],
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.getGoRoutes(navigatorKey),
        );
      },
    );
  }
}