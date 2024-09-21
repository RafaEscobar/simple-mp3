import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadScreen extends StatelessWidget{
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Estamos buscando tu música...',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22
                ),
              ),
              const SizedBox(height: 38,),
              SizedBox(
                width: size.width * .4,
                child: Lottie.asset('assets/animations/load.json'),
              ),
              const SizedBox(height: 30,),
              const Text(
                'Esto solo sucedera una vez.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}