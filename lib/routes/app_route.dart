import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_mp3/screens/load_screen.dart';
import 'package:simple_mp3/screens/player_screen.dart';

class AppRoute {
  static RouterConfig<Object>? getGoRoutes(GlobalKey<NavigatorState> navigatorKey){
    List<RouteBase> routes = [
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) => const LoadScreen(),
        routes: [
          GoRoute(
            path: PlayerScreen.routeName,
            name: PlayerScreen.routeName,
            builder: (BuildContext context, GoRouterState state) => const PlayerScreen()
          )
        ]
      )
    ];

    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey
    );
  }
}