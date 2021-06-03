/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class AppBarItemsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Column _getItemWidget(IconData icon, String title) {
      return Column(
        children: [
          Icon(icon, color: Colors.grey[800]),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 10,
            ),
          ),
        ],
      );
    }

    Widget _profileItem = Column(
      children: [
        Icon(Icons.person, color: Colors.grey[800]),
        Row(
          children: [
            Text(
              'Eu',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 10,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[800]),
          ],
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _getItemWidget(Icons.home, 'Início'),
        const SizedBox(width: 4),
        _getItemWidget(Icons.people, 'Minha rede'),
        const SizedBox(width: 4),
        _getItemWidget(Icons.wallet_travel_rounded, 'Vagas'),
        const SizedBox(width: 4),
        _getItemWidget(Icons.message, 'Mensagens'),
        const SizedBox(width: 4),
        _getItemWidget(Icons.notifications, 'Notificações'),
        const SizedBox(width: 4),
        _profileItem,
      ],
    );

  }

}