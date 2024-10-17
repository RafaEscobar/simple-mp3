import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ControlsPlayer extends StatefulWidget {
  final double height;
  final String musicName;
  const ControlsPlayer({
    super.key,
    required this.height,
    required this.musicName
  });

  @override
  State<ControlsPlayer> createState() => _ControlsPlayerState();
}

class _ControlsPlayerState extends State<ControlsPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: widget.height * .12,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.white
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                  width: widget.height * .06,
                  height: widget.height * .06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 0.8
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                  widget.musicName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            child: Row(
              children: [
                Icon(
                  Ionicons.play_back_circle_outline,
                  size: 40,
                ),
                SizedBox(width: 12,),
                Icon(
                  Ionicons.play_circle_outline,
                  size: 40,
                ),
                SizedBox(width: 12,),
                Icon(
                  Ionicons.play_forward_circle_outline,
                  size: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}