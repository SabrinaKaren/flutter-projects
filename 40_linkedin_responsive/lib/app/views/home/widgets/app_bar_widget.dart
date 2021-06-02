/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/views/home/widgets/app_bar_items_widget.dart';

class AppBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _mobileAppBar = Container(

    );

    Widget _tabletAppBar = Container(

    );

    Widget _webAppBar = Row(
      children: [
        Expanded(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Image.asset('assets/linkedin_icon_01.png', height: 40),
          ),
        ),
        const SizedBox(width: 4),
        Container(
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
        ),
        const SizedBox(width: 4),
        AppBarItemsWidget(),
      ],
    );

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      title: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000),
        child: _webAppBar,
      ),
    );

  }

}