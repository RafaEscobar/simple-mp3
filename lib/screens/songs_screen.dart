import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/models/song.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';
import 'package:simple_mp3/widgets/player/player_card.dart';
import 'package:simple_mp3/widgets/tools_row.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProviderRead = context.read<AppProvider>();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        children: [
          const ToolsRow(),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: appProviderRead.songList.length,
              itemBuilder: (context, index) {
                Song currentSong = appProviderRead.songList[index];
                return PlayerCard(size: size, song: currentSong,);
              },
            ),
          )
        ],
      ),
    );
  }
}