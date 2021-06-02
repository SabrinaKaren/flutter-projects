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
          Icon(icon, color: Colors.black),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      );
    }

    return Row(
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
        _getItemWidget(Icons.person, 'Eu'),
      ],
    );

  }

}