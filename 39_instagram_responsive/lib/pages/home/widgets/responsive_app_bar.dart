/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:instagram_responsive/pages/home/widgets/responsive_right_icons.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _searchField = Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Icon(Icons.search, size: 15),
              const SizedBox(width: 4),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return AppBar(
      backgroundColor: Colors.black,
      elevation: 1,
      title: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Row(
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    'Flutter',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Billabong',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: MOBILE),
                ],
                child: _searchField,
              ),
              ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.largerThan(name: MOBILE),
                ],
                child: Expanded(child: ResponsiveRightIcons()),
                replacement: ResponsiveRightIcons(),
              ),
            ],
          ),
        ),
      ),
    );

  }

}