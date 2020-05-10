/*
  Sabrina Karen
*/

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class NumbersTab extends StatefulWidget {
  @override
  _NumbersTabState createState() => _NumbersTabState();
}

class _NumbersTabState extends State<NumbersTab> {

  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _play(String audioName){
    _audioCache.play(audioName + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "1.mp3", "2.mp3", "3.mp3", "4.mp3", "5.mp3", "6.mp3"
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
            _play("1");
          },
          child: Image.asset("assets/images/1.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("2");
          },
          child: Image.asset("assets/images/2.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("3");
          },
          child: Image.asset("assets/images/3.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("4");
          },
          child: Image.asset("assets/images/4.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("5");
          },
          child: Image.asset("assets/images/5.png"),
        ),
        GestureDetector(
          onTap: (){
            _play("6");
          },
          child: Image.asset("assets/images/6.png"),
        ),
      ],
    );

  }

}