/*
  Sabrina Karen
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _tasksList = [];
  TextEditingController _taskController = TextEditingController();
  Map<String, dynamic> _lastTaskRemoved = Map();

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  _saveFile() async {

    var file = await _getFile();

    String tasksJson = json.encode(_tasksList);
    file.writeAsString(tasksJson);

  }

  _readFile() async {

    try{
      final file = await _getFile();
      return file.readAsString();
    } catch(error){
      return null;
    }

  }

  _saveTask(){

    String newTask = _taskController.text;

    Map<String, dynamic> tasksMap = Map();
    tasksMap["title"] = newTask;
    tasksMap["done"] = false;

    setState(() {
      _tasksList.add(tasksMap);
    });

    _saveFile();

    _taskController.text = "";

  }

  @override
  void initState() {
    super.initState();
    _readFile().then(
        (data){
          setState(() {
            _tasksList = json.decode(data);
          });
        }
    );
  }

  Widget _createItemList(context, index){

    final item = _tasksList[index];

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){

        _lastTaskRemoved = _tasksList[index];

        _tasksList.removeAt(index);
        _saveFile();

        final snackbar = SnackBar(
          duration: Duration(seconds: 10),
          backgroundColor: Colors.green,
          content: Text(
            "Tarefa removida",
            style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          action: SnackBarAction(
            label: "Desfazer",
            textColor: Colors.white,
            onPressed: (){
              setState(() {
                _tasksList.insert(index, _lastTaskRemoved);
              });
              _saveFile();
            },
          ),
        );
        
        Scaffold.of(context).showSnackBar(snackbar);

      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white,),
          ],
        )
      ),
      child: CheckboxListTile(
        title: Text(item["title"]),
        value: item["done"],
        onChanged: (checked){
          setState(() {
            item["done"] = checked;
            _saveFile();
          });
        },
        activeColor: Colors.purple,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    //_saveFile();
    print("itens: " + _tasksList.toString() );

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasksList.length,
              itemBuilder: _createItemList
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 20,
        child: Icon(Icons.add),
          onPressed: (){
            showDialog(
                context: context,
              builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar tarefa"),
                    content: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: "Digite sua tarefa",
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          _saveTask();
                        },
                      ),
                    ],
                  );
              }
            );
          },
      ),

    );

  }

}