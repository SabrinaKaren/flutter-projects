/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/models/post_model.dart';
import 'package:linkedin_responsive/app/models/profile_identification_model.dart';

class PostItem extends StatefulWidget {
  final PostModel postObject;
  PostItem({
    this.postObject,
  });
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          ProfileIdentificationModel().buildProfileWidget(widget.postObject.profileIdentificationObject),
          const SizedBox(height: 20),
          Text(
            widget.postObject.postText,
          ),
          const SizedBox(height: 20),
          Image.asset(widget.postObject.postImg),
        ],
      ),
    );

  }

}