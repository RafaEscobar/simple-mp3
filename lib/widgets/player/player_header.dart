import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PlayerHeader extends StatelessWidget{
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Ionicons.options_outline,
            size: 32,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: .5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: .5,
                  ),
                ),
                contentPadding: const EdgeInsets.all(0),
                hintText: 'Buscar canción',
                prefixIcon: const Icon(
                  Ionicons.search,
                  size: 22,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}