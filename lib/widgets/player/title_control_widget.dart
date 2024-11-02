import 'package:flutter/material.dart';
import 'package:simple_mp3/widgets/player/marquee_widget.dart';

class TitleControlWidget extends StatelessWidget {
  const TitleControlWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return (title.isEmpty) ?
      const MarqueeWidget(title: 'Reproduce una canción') :
      (title.length > 14) ?
        MarqueeWidget(title: title) :
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title,),
        );
  }
}