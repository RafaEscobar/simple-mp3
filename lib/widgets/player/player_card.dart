import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_mp3/models/song.dart';
import 'package:simple_mp3/services/custom_string_service.dart';
import 'package:simple_mp3/services/player_service.dart';
import 'package:simple_mp3/services/providers/app_provider.dart';

class PlayerCard extends StatefulWidget {
  final Song song;
  final int index;
  const PlayerCard({
    super.key,
    required this.song,
    required this.index
  });

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProviderRead = context.read<AppProvider>();
    AppProvider appProviderWatch = context.watch<AppProvider>();
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: const BoxDecoration(borderRadius: BorderRadius.zero,),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {
            appProviderRead.currentSong = widget.song;
            appProviderRead.currentIndex = widget.index;
            PlayerService.toogleMusic(index: widget.index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: size.height * .08,
                            height: size.height * .08,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5)
                                ),
                              ],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.memory(
                              widget.song.coverPage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/album_default.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: (appProviderWatch.isReproducing && widget.song.path == appProviderWatch.currentSong.path),
                            child: Positioned.fill(
                              child: Center(
                                child: Lottie.asset('assets/animations/reproducing.json'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CustomStringService.cropTitle(data: widget.song.title, length: 18),
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
                                CustomStringService.cropTitle(data: widget.song.artist, length: 18),
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
        )
      )
    );
  }
}