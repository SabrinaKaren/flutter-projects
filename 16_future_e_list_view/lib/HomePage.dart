/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'PostData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<PostData>> _getPostDynamic() async {

    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response _apiReturn = await http.get(url);
    var jsonData = json.decode(_apiReturn.body);

    List<PostData> _postList = List();
    for (var item in jsonData){
      PostData newPost = PostData(item["userId"], item["id"], item["title"], item["body"]);
      _postList.add(newPost);
    }

    return _postList;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Future e list view"),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<List<PostData>>(
        future: _getPostDynamic(),
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
              if (snapshot.hasError){
                return Center(
                  child: AlertDialog(
                      title: Text("Não foi possível carregar os dados")
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      List<PostData> postList = snapshot.data;
                      PostData item = postList[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.id.toString()),
                      );
                    });
              }
              break;
          }

        },
      ),
    );

  }

}