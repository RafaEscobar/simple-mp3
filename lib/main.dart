import 'package:flutter/material.dart';
import 'package:simple_mp3/routes/app_route.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoute.getGoRoutes(navigatorKey),
    );
  }
}