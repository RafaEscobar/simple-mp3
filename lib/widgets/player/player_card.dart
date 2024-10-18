import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_mp3/models/song.dart';

class PlayerCard extends StatefulWidget {
  final Size size;
  final Song song;
  const PlayerCard({
    super.key,
    required this.size,
    required this.song
  });

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                  width: widget.size.height * .08,
                  height: widget.size.height * .08,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 0.8
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Image.memory(widget.song.coverPage!),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song.title,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 2,),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.folder_outline,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6,),
                        Text(
                          widget.song.artist,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: const Icon(
              Ionicons.ellipsis_vertical_circle_outline,
              color: Colors.white,
            )
          )
        ],
      ),
    );
  }
}