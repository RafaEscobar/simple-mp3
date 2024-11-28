import 'package:flutter/material.dart';
import 'package:simple_mp3/screens/sections/directories_screen.dart';
import 'package:simple_mp3/screens/sections/favorites_screen.dart';
import 'package:simple_mp3/screens/sections/songs_screen.dart';
import 'package:simple_mp3/theme/app_theme.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  static const String routeName = 'player-screen';

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const SongsScreen(),
    const DirectoriesScreen(),
    const FavoritesScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: pages[currentIndex]
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppTheme.secondary, width: 2)
                  )
                ),
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: IconButton(onPressed: () => (), icon: const Icon(Icons.blur_on, size: 40, color: AppTheme.secondary,)),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.music_note_outlined, size: 40, color: AppTheme.secondary,),
                            onPressed: () => setState(() => currentIndex = 0)
                          ),
                          const SizedBox(height: 12,),
                          IconButton(
                            icon: const Icon(Icons.folder_outlined, size: 40, color: AppTheme.secondary,),
                            onPressed: () => setState(() => currentIndex = 1)
                          ),
                          const SizedBox(height: 12,),
                          IconButton(
                            icon: const Icon(Icons.favorite_outline, size: 40, color: AppTheme.secondary,),
                            onPressed: () => setState(() => currentIndex = 2)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppTheme.secondary,
                              shape: BoxShape.circle
                            ),
                          ),
                          const Text('nsoseode'),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}