/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarItemsWidget extends StatefulWidget {
  @override
  _AppBarItemsWidgetState createState() => _AppBarItemsWidgetState();
}

class _AppBarItemsWidgetState extends State<AppBarItemsWidget> {

  bool selectedHome = true;
  bool selectedMyNetwork = false;
  bool selectedVacations = false;
  bool selectedMessages = false;
  bool selectedNotifications = false;
  bool selectedMe = false;

  @override
  Widget build(BuildContext context) {

    Padding _getItemWidget(IconData icon, String title, bool selected) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.black : Colors.grey[600]),
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.black : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    Column _getProfileItem(bool selected) {
      return Column(
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
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: _getItemWidget(Icons.home, 'Início', selectedHome),
          onTap: () {
            setState(() {
              selectedHome = true;
              selectedMyNetwork = false;
              selectedVacations = false;
              selectedMessages = false;
              selectedNotifications = false;
              selectedMe = false;
            });
          },
        ),
        GestureDetector(
          child: _getItemWidget(Icons.people, 'Minha rede', selectedMyNetwork),
          onTap: () {
            setState(() {
              selectedHome = false;
              selectedMyNetwork = true;
              selectedVacations = false;
              selectedMessages = false;
              selectedNotifications = false;
              selectedMe = false;
            });
          },
        ),
        GestureDetector(
          child: _getItemWidget(Icons.wallet_travel_rounded, 'Vagas', selectedVacations),
          onTap: () {
            setState(() {
              selectedHome = false;
              selectedMyNetwork = false;
              selectedVacations = true;
              selectedMessages = false;
              selectedNotifications = false;
              selectedMe = false;
            });
          },
        ),
        GestureDetector(
          child: _getItemWidget(Icons.message, 'Mensagens', selectedMessages),
          onTap: () {
            setState(() {
              selectedHome = false;
              selectedMyNetwork = false;
              selectedVacations = false;
              selectedMessages = true;
              selectedNotifications = false;
              selectedMe = false;
            });
          },
        ),
        GestureDetector(
          child: _getItemWidget(Icons.notifications, 'Notificações', selectedNotifications),
          onTap: () {
            setState(() {
              selectedHome = false;
              selectedMyNetwork = false;
              selectedVacations = false;
              selectedMessages = false;
              selectedNotifications = true;
              selectedMe = false;
            });
          },
        ),
        GestureDetector(
          child: _getProfileItem(selectedMe),
          onTap: () {
            setState(() {
              selectedHome = false;
              selectedMyNetwork = false;
              selectedVacations = false;
              selectedMessages = false;
              selectedNotifications = false;
              selectedMe = true;
            });
          },
        ),
      ],
    );

  }

}