/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  VideoPlayerController _videoUrlController;
  VideoPlayerController _videoLocalController;
  TabController _tabController;

  @override
  void initState() {

    super.initState();

    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: 0
    );

    _videoUrlController = VideoPlayerController.network(
      "http://techslides.com/demos/sample-videos/small.mp4"
    )..initialize().then( (_){
      setState(() {
        _videoUrlController.play();
      });
    } );

    _videoLocalController = VideoPlayerController.asset(
        "videos/exemplo.mp4"
    )..setLooping(true)
    ..initialize().then( (_){
      setState(() {
        _videoLocalController.play();
      });
    } );

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Executando vídeos"),
          bottom: TabBar(
            controller: _tabController,
            //indicatorWeight: 4,
            //indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "URL",
              ),
              Tab(
                text: "Local",
              ),
            ],
          )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: AspectRatio(
              aspectRatio: _videoUrlController.value.aspectRatio,
              child: VideoPlayer(_videoUrlController),
            )
          ),
          Center(
            child: AspectRatio(
              aspectRatio: _videoLocalController.value.aspectRatio,
              child: VideoPlayer(_videoLocalController),
            )
          ),
        ],
      ),
    );

  }

}