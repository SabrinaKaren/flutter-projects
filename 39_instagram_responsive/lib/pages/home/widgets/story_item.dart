/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: 66,
          width: 66,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 27,
              backgroundImage: AssetImage('assets/my_profile_02.jpg'),
            ),
          ),
        ),
        Text(
          'sabrina_karen_s',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );

  }

}