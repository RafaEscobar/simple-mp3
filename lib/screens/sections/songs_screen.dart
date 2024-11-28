import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/models/song.dart';
import 'package:simple_mp3/services/providers/player_provider.dart';
import 'package:simple_mp3/widgets/player/player_card.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) {
    PlayerProvider appProviderRead = context.read<PlayerProvider>();
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appProviderRead.songList.length,
              itemBuilder: (context, index) {
                Song currentSong = appProviderRead.songList[index];
                return PlayerCard(song: currentSong);
              },
            ),
          )
        ],
      ),
    );
  }
}