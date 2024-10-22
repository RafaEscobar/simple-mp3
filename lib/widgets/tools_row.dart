import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ToolsRow extends StatelessWidget {
  const ToolsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Ionicons.shuffle,
            color: Colors.white,
            size: 32,
          ),
          Icon(
            Ionicons.filter_circle_outline,
            color: Colors.white,
            size: 32,
          )
        ],
      ),
    );
  }
}