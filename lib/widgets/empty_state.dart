import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget{
  final String lottiePath;
  final String title;
  final String subtitle;
  const EmptyState({
    super.key,
    required this.lottiePath,
    required this.title,
    this.subtitle = ''
  });


  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: Column(
        children: [
          Lottie.asset(lottiePath),
          const SizedBox(height: 10,),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6,),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200
            ),
          )
        ],
      ),
    );
  }
}