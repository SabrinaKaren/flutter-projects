/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class ProfileIdentificationModel {

  ProfileIdentificationModel({
    this.name,
    this.profileImgPath,
    this.occupation,
    this.postMoment,
  });

  String name;
  String profileImgPath;
  String occupation;
  String postMoment;

  Widget buildProfileWidget(ProfileIdentificationModel profileIdentificationObject) {

    Widget _moment = Row(
      children: [
        Text(
          profileIdentificationObject.postMoment,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        Text(
          ' • ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        Icon(
          Icons.public,
          color: Colors.grey[700],
          size: 18,
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(profileIdentificationObject.profileImgPath),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  profileIdentificationObject.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileIdentificationObject.occupation,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                _moment,
              ],
            ),
          ],
        ),
        MouseRegion(
          child: GestureDetector(
            child: Icon(Icons.more_horiz_rounded, color: Colors.grey[700], size: 28),
            onTap: () => print('Options'),
          ),
          cursor: SystemMouseCursors.click,
        ),
      ],
    );

  }

}