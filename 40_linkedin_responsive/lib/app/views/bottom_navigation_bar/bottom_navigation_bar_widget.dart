/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {

  int _selectedIndex;

  _onSelectMenu(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> itemsList = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Minha rede'),
      BottomNavigationBarItem(icon: Icon(Icons.add_box_sharp), label: 'Publicação'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificações'),
      BottomNavigationBarItem(icon: Icon(Icons.wallet_travel_rounded), label: 'Vagas'),
    ];

    return BottomNavigationBar(
      items: itemsList,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[600],
      onTap: _onSelectMenu,
    );

  }

}