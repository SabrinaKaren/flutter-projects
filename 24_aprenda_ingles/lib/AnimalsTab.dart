/*
  Sabrina Karen
*/

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AnimalsTab extends StatefulWidget {
  @override
  _AnimalsTabState createState() => _AnimalsTabState();
}

class _AnimalsTabState extends State<AnimalsTab> {

  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _play(String audioName){
    _audioCache.play(audioName + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "cao.mp3", "gato.mp3", "leao.mp3", "macaco.mp3", "ovelha.mp3", "vaca.mp3"
    ]);
  }

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            _play("cao");
          },
          child: Image.asset("assets/images/cao.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("gato");
          },
          child: Image.asset("assets/images/gato.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("leao");
          },
          child: Image.asset("assets/images/leao.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("macaco");
          },
          child: Image.asset("assets/images/macaco.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("ovelha");
          },
          child: Image.asset("assets/images/ovelha.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("vaca");
          },
          child: Image.asset("assets/images/vaca.png"),
        ),
      ],
    );

  }

}