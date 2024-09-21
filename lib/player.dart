import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  Future<List<String>> searchFiles() async {
    List<String> paths = [];
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      List<String> restrictedDirectories = [
        '/storage/emulated/0/Android',
        '/storage/emulated/0/Android/data',
        '/storage/emulated/0/Android/obb',
      ];

      Future<void> listFiles(Directory dir) async {
        bool isRequired = true;
        try {
          List<FileSystemEntity> entities = dir.listSync();
          for (FileSystemEntity entity in entities) {
            if (entity is Directory) {
              isRequired = restrictedDirectories.any((restrictedDir) => entity.path.startsWith(restrictedDir));
              if (!isRequired) {
                await listFiles(Directory(entity.path));
              }
            } else if (entity is File && entity.path.endsWith('.mp3')) {
              paths.add(entity.path);
            }
          }
        } catch (e) {
          print("ERROR: ${e.toString()}");
        }
      }

      Directory rootDir = Directory('/storage/emulated/0');
      await listFiles(rootDir);
    } else {
      print("Permiso denegado");
    }
    return paths;
  }

  @override
  void initState() {
    super.initState();
    searchFiles();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: searchFiles(),
          builder: (context, snapshot) {
            Widget body;
            if (snapshot.connectionState == ConnectionState.waiting) {
              body = const Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasError) {
              body = const Center(
                child: Text('Ha ocurrido un error'),
              );
            } else if(!snapshot.hasData || (snapshot.data ?? []).isEmpty) {
              body = const Center(
                child: Text('No tienes musica en tu dispositivo'),
              );
            } else {
              List<String> paths = snapshot.data!;

              body = ListView.builder(
                itemCount: paths.length,
                itemBuilder: (context, index) {
                  return Text(paths[index]);
                },
              );
            }
            return body;
          },
        )
      ),
    );
  }
}