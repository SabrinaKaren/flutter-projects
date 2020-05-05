/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class StartPage extends StatefulWidget {

  String research;

  StartPage (this.research);

  @override
  _StartPageState createState() => _StartPageState();

}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {

    Future<List<Video>> _showVideos(String toResearch){
      Api api = Api();
      return api.research(toResearch);
    }

    return FutureBuilder<List<Video>>(
      future: _showVideos(widget.research),
      builder: (context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.none :
          case ConnectionState.waiting :
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active :
          case ConnectionState.done :
            if (snapshot.hasData){
              return ListView.separated(
                  itemBuilder: (context, index){

                    Video video = snapshot.data[index];

                    return GestureDetector(
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: YOUTUBE_API_KEY,
                            videoId: video.id,
                          autoPlay: true,
                          fullScreen: true
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(video.image),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(video.title),
                            subtitle: Text(video.channel),
                          )
                        ],
                      ),
                    );

                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data.length
              );
            } else {
              return Center(
                child: Text("Nenhum video a ser exibido.")
              );
              break;
            }
        }
      },
    );

  }

}
