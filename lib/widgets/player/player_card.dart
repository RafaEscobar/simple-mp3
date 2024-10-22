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

  String cropTitle(String title){
    if (title.length<18) return title;
    return "${title.substring(0, 18)}...";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
                      boxShadow: const[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5)
                        )
                      ],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.memory(
                      widget.song.coverPage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cropTitle(widget.song.title),
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 2,),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.musical_note,
                            size: 16,
                            color: Colors.white,
                          ),
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
      ),
    );
  }
}