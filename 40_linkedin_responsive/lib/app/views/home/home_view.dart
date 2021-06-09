/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/views/home/widgets/left_discovery_card.dart';
import 'package:linkedin_responsive/app/views/home/widgets/left_profile_card.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/timeline_widget.dart';
import 'package:linkedin_responsive/app/views/home/widgets/to_do_post.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveWrapper.of(context).isMobile;

    MouseRegion _sortBy = MouseRegion(
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Divider(),
            ),
            Text(
              '  Classificar por: ',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Principais ',
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
          ],
        ),
        onTap: () => print('Classificar por'),
      ),
      cursor: SystemMouseCursors.click,
    );

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveVisibility(
              visible: false,
              visibleWhen: [
                Condition.largerThan(name: 'SMALLER_TABLET'),
              ],
              child: Column(
                children: [
                  LeftProfileCard(),
                  const SizedBox(height: 10),
                  LeftDiscoveryCard(),
                ],
              ),
            ),
            ResponsiveVisibility(
              visible: false,
              visibleWhen: [
                Condition.largerThan(name: 'SMALLER_TABLET'),
              ],
              child: Column(
                children: [
                  SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Visibility(
                    visible: !isMobile,
                    child: Column(
                      children: [
                        ToDoPost(),
                        SizedBox(height: 10),
                        _sortBy,
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  TimeLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}