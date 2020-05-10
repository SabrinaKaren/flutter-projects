/*
  Sabrina Karen
*/

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class VowelsTab extends StatefulWidget {
  @override
  _VowelsTabState createState() => _VowelsTabState();
}

class _VowelsTabState extends State<VowelsTab> {

  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _play(String audioName){
    _audioCache.play(audioName + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "a.mp3", "e.mp3", "i.mp3", "o.mp3", "u.mp3"
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
            _play("a");
          },
          child: Image.asset("assets/images/a.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("e");
          },
          child: Image.asset("assets/images/e.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("i");
          },
          child: Image.asset("assets/images/i.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("o");
          },
          child: Image.asset("assets/images/o.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("u");
          },
          child: Image.asset("assets/images/u.png"),
        ),
      ],
    );

  }

}