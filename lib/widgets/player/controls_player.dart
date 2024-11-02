import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/services/player_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';
import 'package:simple_mp3/widgets/player/title_control_widget.dart';

class ControlsPlayer extends StatefulWidget {
  const ControlsPlayer({super.key});

  @override
  State<ControlsPlayer> createState() => _ControlsPlayerState();
}

class _ControlsPlayerState extends State<ControlsPlayer> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProviderRead = context.watch<AppProvider>();
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height * .12,
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
                  width: size.width * .18,
                  height: size.height * .08,
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
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/album_default.jpg', fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
                SizedBox(width: size.width * .02,),
                SizedBox(
                  width: size.width * .32,
                  height: size.height * .1,
                  child: TitleControlWidget(title: appProviderRead.currentSong.title)
                )
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => (),
                  icon: const Icon(
                    Ionicons.play_back_circle_outline,
                    size: 38,
                  )
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async => PlayerService.playMusic(appProviderRead.currentSong.path),
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