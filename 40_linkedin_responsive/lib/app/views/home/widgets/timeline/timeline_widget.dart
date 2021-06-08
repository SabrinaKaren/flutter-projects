/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/models/post_model.dart';
import 'package:linkedin_responsive/app/models/profile_identification_model.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/post_item.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/posts_mock.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {

  List<PostModel> postsList;

  @override
  void initState() {
    super.initState();
    postsList = PostsMock().getPostsMock();
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.builder(
        itemCount: postsList.length,
        itemBuilder: (context, index) {
          return PostItem(postObject: postsList[index]);
        },
      ),
    );

  }

}