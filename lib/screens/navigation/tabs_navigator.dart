import 'package:flutter/material.dart';
import 'package:simple_mp3/screens/directories_screen.dart';
import 'package:simple_mp3/screens/favorites_screen.dart';
import 'package:simple_mp3/screens/songs_screen.dart';
import 'package:tab_container/tab_container.dart';

class TabsNavigator extends StatefulWidget {
  const TabsNavigator({super.key});
  static const String routeName = 'tabs-navigator';

  @override
  State<TabsNavigator> createState() => _TabsNavigatorState();
}

class _TabsNavigatorState extends State<TabsNavigator> with TickerProviderStateMixin{
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Builder(
        builder: (context) {
          return TabContainer(
            controller: _controller,
            tabEdge: TabEdge.top,
            tabsStart: 0.1,
            tabsEnd: 0.9,
            tabMaxLength: 100,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(10),
            childPadding: const EdgeInsets.all(20.0),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            unselectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            colors: const [
              Color(0xFFADD8E6),
              Color(0xFF87CEEB),
              Color(0xFFB0E0E6),
            ],
            tabs: const [
              Text('Canciones'),
              Text('Carpetas'),
              Text('Favoritos'),
            ],
            children: const [
              SizedBox(
                child: SongsScreen(),
              ),
              SizedBox(
                child: DirectoriesScreen(),
              ),
              SizedBox(
                child: FavoritesScreen(),
              ),
            ],
          );
        }
      ),
    );
  }
}