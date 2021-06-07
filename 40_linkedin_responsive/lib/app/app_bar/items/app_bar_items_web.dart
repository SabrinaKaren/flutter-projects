/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/models/app_bar_item_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AppBarItemsWeb extends StatefulWidget {
  @override
  _AppBarItemsWebState createState() => _AppBarItemsWebState();
}

class _AppBarItemsWebState extends State<AppBarItemsWeb> {

  List<AppBarItemModel> itemsList;
  bool selectedMe;
  bool selectedSolutions;
  bool selectedSearch;

  @override
  void initState() {

    super.initState();

    itemsList = [
      AppBarItemModel(icon: Icons.home, title: 'Início', selected: true),
      AppBarItemModel(icon: Icons.people, title: 'Minha rede', selected: false),
      AppBarItemModel(icon: Icons.wallet_travel_rounded, title: 'Vagas', selected: false),
      AppBarItemModel(icon: Icons.message, title: 'Mensagens', selected: false),
      AppBarItemModel(icon: Icons.notifications, title: 'Notificações', selected: false),
    ];
    selectedMe = false;
    selectedSolutions = false;
    selectedSearch = false;

  }

  @override
  Widget build(BuildContext context) {

    void _setFalseSelectedInAll() {
      itemsList.forEach((element) { element.selected = false; });
      selectedMe = false;
      selectedSolutions = false;
      selectedSearch = false;
    }

    ResponsiveVisibility _getSearchItem(bool selected) {
      return ResponsiveVisibility(
        visible: false,
        child: GestureDetector(
          child: MouseRegion(
            child: Column(
              children: [
                Icon(Icons.search, color: Colors.grey[800]),
                Text(
                  'Pesquisar',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            cursor: SystemMouseCursors.click,
          ),
          onTap: () {
            setState(() {
              _setFalseSelectedInAll();
              selectedSearch = true;
            });
          },
        ),
        visibleWhen: [
          Condition.smallerThan(name: TABLET),
        ],
      );
    }

    MouseRegion _getProfileItem(bool selected) {
      return MouseRegion(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 13,
                backgroundImage: AssetImage('assets/my_profile_01.jpg'),
              ),
              Row(
                children: [
                  Text(
                    'Eu',
                    style: TextStyle(
                      color: selected ? Colors.black : Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: selected ? Colors.black : Colors.grey[600], size: 15),
                ],
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _setFalseSelectedInAll();
              selectedMe = true;
            });
          },
        ),
        cursor: SystemMouseCursors.click,
      );
    }

    MouseRegion _getSolutions(bool selected) {
      return MouseRegion(
        child: GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.apps, color: selected ? Colors.black : Colors.grey[600]),
              Row(
                children: [
                  Text(
                    'Soluções',
                    style: TextStyle(
                      color: selected ? Colors.black : Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: selected ? Colors.black : Colors.grey[600], size: 15),
                ],
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _setFalseSelectedInAll();
              selectedSolutions = true;
            });
          },
        ),
        cursor: SystemMouseCursors.click,
      );
    }

    List<Widget> _buildItems() {

      List<Widget> listToReturn = [];

      listToReturn.add(_getSearchItem(selectedSearch));

      for(var i=0; i<itemsList.length; i++) {
        listToReturn.add(
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: MouseRegion(
                child: Column(
                  children: [
                    Icon(
                      itemsList[i].icon,
                      color: itemsList[i].selected ? Colors.black : Colors.grey[600]
                    ),
                    Text(
                      itemsList[i].title,
                      style: TextStyle(
                        color: itemsList[i].selected ? Colors.black : Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                cursor: SystemMouseCursors.click,
              ),
              onTap: () {
                setState(() {
                  _setFalseSelectedInAll();
                  itemsList[i].selected = true;
                });
              },
            ),
          )
        );
      }

      listToReturn.add(_getProfileItem(selectedMe));
      listToReturn.add(
        Container(
          height: 40,
          child: VerticalDivider(color: Colors.grey[500]),
        )
      );
      listToReturn.add(_getSolutions(selectedSolutions));

      return listToReturn;

    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _buildItems(),
    );

  }

}