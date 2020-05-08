/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache(prefix: "audios/");
  bool _firstRun = true;
  double _volume = 0.5;

  _playAudio() async {

    _audioPlayer.setVolume(_volume);

    if (_firstRun){
      _audioPlayer = await _audioCache.play("musica.mp3");
      _firstRun = false;
    } else {
      _audioPlayer.resume();
    }

  }

  _stopAudio() async {
    await _audioPlayer.stop();
  }

  _pauseAudio() async {
    await _audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black38,
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    "min",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Slider(
                  value: _volume,
                  min: 0,
                  max: 1,
                  onChanged: (double newVolume){
                    setState(() {
                      _volume = newVolume;
                    });
                    _audioPlayer.setVolume(newVolume);
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.black26,
                ),
                Text(
                  "max",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/executar.png", height: 70,),
                    onTap: (){
                      _playAudio();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/parar.png", height: 60),
                    onTap: (){
                      _stopAudio();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    child: Image.asset("assets/images/pausar.png", height: 60),
                    onTap: (){
                      _pauseAudio();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

  }

}