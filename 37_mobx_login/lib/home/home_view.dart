/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_login/home/home_controller.dart';
import 'package:mobx_login/login/login_controller.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController _homeController = HomeController();

  _dialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Adicionar item", textAlign: TextAlign.center),
            content: TextField(
              decoration: InputDecoration(
                labelText: 'Digite uma descrição...',
                contentPadding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
              ),
              onChanged: _homeController.addNewItem,
            ),
            actions: [
              TextButton(
                  onPressed: () { Navigator.pop(context); },
                  child: Text("Cancelar", style: TextStyle(
                    color: Colors.red
                  ),)
              ),
              TextButton(
                  onPressed: () {
                    _homeController.addItemInList();
                    Navigator.pop(context);
                  },
                  child: Text("Salvar")
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loginController.email,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: _homeController.taskList.length,
            itemBuilder: (_, index) {

              var item= _homeController.taskList[index];

              return Observer(
                builder: (_) {
                  return ListTile(
                    title: Text(
                      item.title,
                      style: TextStyle(
                        decoration: item.status ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    leading: Checkbox(
                      value: item.status,
                      onChanged: item.changeStatus,
                    ),
                    onTap: () {
                      item.status = !item.status;
                    },
                  );
                },
              );

            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _dialog();
        },
      ),
    );

  }

}