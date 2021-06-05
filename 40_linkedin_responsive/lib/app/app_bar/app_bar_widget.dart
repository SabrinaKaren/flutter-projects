/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'app_bar_items_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _searchBox = Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xffE0ECF9),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[800]),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
                hintText: 'Pesquisar',
              ),
            ),
          ),
        ],
      ),
    );

    Widget _mobileAppBar = Container(
      child: Text('mobile', style: TextStyle(color: Colors.red)),
    );

    Widget _tabletAppBar = Container(
      child: Text('tablet', style: TextStyle(color: Colors.red)),
    );

    Widget _webAppBar = Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Image.asset('assets/linkedin_icon_01.png', height: 40),
        ),
        const SizedBox(width: 4),
        _searchBox,
        const SizedBox(width: 4),
        Expanded(child: AppBarItemsWidget()),
      ],
    );

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      title: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: ResponsiveVisibility(
            visible: false,
            visibleWhen: [
              Condition.smallerThan(name: MOBILE),
            ],
            child: _mobileAppBar,
            replacement: ResponsiveVisibility(
              visible: false,
              visibleWhen: [
                //Condition.largerThan(name: MOBILE),
                Condition.smallerThan(name: TABLET),
              ],
              child: _tabletAppBar,
              replacement: _webAppBar,
            ),
          ),
        ),
      ),
    );

  }

}