/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/views/home/widgets/left_discovery_card.dart';
import 'package:linkedin_responsive/app/views/home/widgets/left_profile_card.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/timeline_widget.dart';
import 'package:responsive_framework/responsive_value.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

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
            TimeLine(),
          ],
        ),
      ),
    );

  }

}