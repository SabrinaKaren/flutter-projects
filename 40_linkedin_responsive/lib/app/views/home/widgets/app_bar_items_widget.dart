/*
  Sabrina Karen
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarItemsWidget extends StatelessWidget {

  bool selectedHome = true;
  bool selectedMyNetwork = false;
  bool selectedVacations = false;
  bool selectedMessages = false;
  bool selectedNotifications = false;

  @override
  Widget build(BuildContext context) {

    Padding _getItemWidget(IconData icon, String title, bool selected) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.black : Colors.grey[800]),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    Widget _profileItem = Column(
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
                color: Colors.grey[800],
                fontSize: 10,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[800], size: 15),
          ],
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _getItemWidget(Icons.home, 'Início', selectedHome),
        _getItemWidget(Icons.people, 'Minha rede', selectedMyNetwork),
        _getItemWidget(Icons.wallet_travel_rounded, 'Vagas', selectedVacations),
        _getItemWidget(Icons.message, 'Mensagens', selectedMessages),
        _getItemWidget(Icons.notifications, 'Notificações', selectedNotifications),
        _profileItem,
      ],
    );

  }

}