import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyState extends StatelessWidget{
  final String lottiePath;
  final String title;
  final String subtitle;
  final Widget? body;
  const EmptyState({
    super.key,
    required this.lottiePath,
    required this.title,
    this.subtitle = '',
    this.body
  });


  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          const SizedBox(height: 20,),
          body ?? Container()
        ],
      ),
    );
  }
}