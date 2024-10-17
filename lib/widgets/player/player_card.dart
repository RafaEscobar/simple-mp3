import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PlayerCard extends StatefulWidget {
  final Size size;
  const PlayerCard({
    super.key,
    required this.size
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
                ),
                const SizedBox(width: 10,),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre de la canción',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Icon(
                          Ionicons.folder_outline,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6,),
                        Text(
                          'Nombre de la carpeta',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white),
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