import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        children: [
          const ToolsRow(),
          const SizedBox(height: 20,),
          PlayerCard(size: size)
        ],
      ),
    );
  }
}