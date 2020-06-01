/*
  Sabrina Karen
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/LoginPage.dart';
import 'package:whatsapp/Tabs/ContactsTab.dart';
import 'package:whatsapp/tabs/ConversationsTab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<String> menuItems = ["Configurações", "Deslogar"];
  String _userEmail = "";

  Future _getUserData() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser activeUser = await auth.currentUser();

    setState(() {
      _userEmail = activeUser.email;
    });

  }

  _choiceOfMenu(String chosenItem){

    switch(chosenItem){
      case "Configurações":
        Navigator.pushNamed(context, "/config");
        break;
      case "Deslogar":
        _logoutUser();
        break;
    }

  }

  _logoutUser() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Login()
        )
    );

  }

  Future _treatmentIfUserIsLogged() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser activeUser = await auth.currentUser();

    if(activeUser == null){
      Navigator.pushReplacementNamed(context, "/login");
    }

  }

  @override
  void initState() {
    super.initState();
    _treatmentIfUserIsLogged();
    _getUserData();
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: 0
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          tabs: <Widget>[
            Tab(text: "Conversas",),
            Tab(text: "Contatos",),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _choiceOfMenu,
            itemBuilder: (context){
              return menuItems.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ConversationsTab(),
          ContactsTab(),
        ],
      ),
    );

  }

}