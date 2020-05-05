/*
  Sabrina Karen teste2
 */

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const YOUTUBE_API_KEY = "AIzaSyAsPQ20n66SUYgQR55oES_-rrCJqJQpmoc";
const CHANNEL_ID = "UCj0O6W8yDuLg3iraAXKgCrQ";
const BASE_URL = "https://www.googleapis.com/youtube/v3/";

class Api{

  Future<List<Video>> research(String toResearch) async {

    http.Response response = await http.get(
        BASE_URL + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$YOUTUBE_API_KEY"
            //"&channelId=$CHANNEL_ID"
            "&q=$toResearch"
    );

    if (response.statusCode == 200){

      Map<String, dynamic> responseJson = json.decode( response.body );
      List<Video> videosList = responseJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videosList;

    }

  }

}