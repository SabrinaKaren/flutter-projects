/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:instagram_responsive/pages/home/widgets/post_item.dart';
import 'package:instagram_responsive/pages/home/widgets/responsive_app_bar.dart';
import 'package:instagram_responsive/pages/home/widgets/stories_list.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(preferredSize: Size(double.infinity, 52), child: ResponsiveAppBar()),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: ListView(
            children: [
              StoriesList(),
              PostItem(),
              PostItem(),
              PostItem(),
              PostItem(),
              PostItem(),
            ],
          ),
        ),
      ),
    );
  }

}