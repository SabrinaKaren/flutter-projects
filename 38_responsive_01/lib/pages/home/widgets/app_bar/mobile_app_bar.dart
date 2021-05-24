/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        'Flutter',
      ),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
      ],
    );
  }

}