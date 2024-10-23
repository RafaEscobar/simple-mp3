import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

class ControlsPlayer extends StatefulWidget {
  final Size size;
  final Function(String) playMusic;
  const ControlsPlayer({
    super.key,
    required this.size,
    required this.playMusic,
  });

  @override
  State<ControlsPlayer> createState() => _ControlsPlayerState();
}

class _ControlsPlayerState extends State<ControlsPlayer> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProviderRead = context.watch<AppProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: widget.size.height * .12,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widget.size.width * .18,
                  height: widget.size.height * .08,
                  child: (appProviderRead.currentSong.coverPage == null) ?
                  const Icon(
                    Ionicons.musical_note_outline,
                    color: Colors.black,
                    size: 40,
                  ) :
                  Container(
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
                        appProviderRead.currentSong.coverPage!,
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                SizedBox(width: widget.size.width * .02,),
                SizedBox(
                  width: widget.size.width * .32,
                  height: widget.size.height * .1,
                  child: Marquee(
                    text: appProviderRead.currentSong.title.isNotEmpty
                      ? appProviderRead.currentSong.title
                      : "Reproduce una canción",
                      scrollAxis: Axis.horizontal,
                      blankSpace: 10.0,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {

                  },
                  icon: const Icon(
                    Ionicons.play_back_circle_outline,
                    size: 38,
                  )
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    widget.playMusic(appProviderRead.currentSong.path);
                  },
                  icon: const Icon(
                    Ionicons.play_circle_outline,
                    size: 38,
                  ),
                ),

                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {

                  },
                  icon: const Icon(
                    Ionicons.play_forward_circle_outline,
                    size: 38,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}