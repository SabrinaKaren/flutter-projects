/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:instagram_responsive/pages/home/widgets/story_item.dart';
import 'package:responsive_framework/responsive_framework.dart';

class StoriesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mobile = ResponsiveWrapper.of(context).isMobile;

    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(vertical: mobile ? 15 : 35),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: 16,
        itemBuilder: (_, index) => StoryItem(),
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );

  }

}