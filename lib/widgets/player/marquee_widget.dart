import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeWidget extends StatelessWidget {
  const MarqueeWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: title,
      scrollAxis: Axis.horizontal,
      blankSpace: 40.0,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400
      ),
    );
  }
}