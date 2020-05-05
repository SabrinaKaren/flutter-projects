/*
  Sabrina Karen
 */

class Video{

  String id;
  String title;
  String description;
  String image;
  String channel;

  Video({this.id, this.title, this.description, this.image, this.channel});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      description: json["snippet"]["description"],
      image: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"],
    );
  }

}