/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'items/app_bar_items_web.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveWrapper.of(context).isMobile;
    final isSmallerTablet = ResponsiveWrapper.of(context).activeBreakpoint.name == 'SMALLER_TABLET' ? true : false;
    final isDesktop = ResponsiveWrapper.of(context).isDesktop;

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

    Widget _webTabletAppBar = Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Image.asset('assets/linkedin_icon_01.png', height: 40),
        ),
        const SizedBox(width: 4),
        ResponsiveVisibility(
          visible: false,
          child: _searchBox,
          visibleWhen: [
            Condition.largerThan(name: 'SMALLER_TABLET'),
          ],
        ),
        //SizedBox(width: isSmallerTablet ? 100 : 160),
        SizedBox(width: isDesktop ? 160
            : isSmallerTablet ? 80 : 50),
        Expanded(child: AppBarItemsWeb()),
      ],
    );

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      title: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Visibility(
            visible: isMobile,
            child: _mobileAppBar,
            replacement: _webTabletAppBar,
          ),
        ),
      ),
    );

  }

}