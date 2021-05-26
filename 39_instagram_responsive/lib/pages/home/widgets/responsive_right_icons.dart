/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveRightIcons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ResponsiveVisibility(
          visible: false,
          visibleWhen: [
            Condition.smallerThan(name: TABLET),
          ],
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print('Clicou no search'),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () => print('Clicou no home'),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => print('Clicou no send'),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () => print('Clicou no favorite_border'),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          child: CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/my_profile_01.jpg'),
          ),
          onTap: () => print('Clicou no avatar'),
        ),
      ],
    );

  }

}