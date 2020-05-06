/*
  Sabrina Karen
 */

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _recoverDataBase () async {

    final dataBasePath = await getDatabasesPath();
    final dataBaseLocal = join(dataBasePath, "banco.db");

    var dataBase = await openDatabase(
        dataBaseLocal,
        version: 1,
        onCreate: (db, recentVersionOfTheDataBase){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER) ";
          db.execute(sql);
        }
    );

    return dataBase;

  }

  _insert() async {

    Database dataBase = await _recoverDataBase();

    Map<String, dynamic> userData = {
      "nome" : "Maria Silva",
      "idade" : 58
    };
    int id = await dataBase.insert("usuarios", userData);
    print("Salvo: $id " );

  }

  _read() async {

    Database dataBase = await _recoverDataBase();

    String sql = "SELECT * FROM usuarios ";
    List users = await dataBase.rawQuery(sql);

  }

  _getUserById(int userId) async {

    Database dataBase = await _recoverDataBase();
    
    List users = await dataBase.query(
      "usuarios",
      columns: ["id", "nome", "idade"],
      where: "id = ?",
      whereArgs: [userId]
    );

  }

  _deleteUser(int userId) async {

    Database dataBase = await _recoverDataBase();

    int amountOfDeleted = await dataBase.delete(
      "usuarios",
        where: "id = ?",
        whereArgs: [userId]
    );

  }

  _updateUser(int userId) async {

    Database dataBase = await _recoverDataBase();

    Map<String, dynamic> userData = {
      "nome" : "Maria Silva alterada",
      "idade" : 40
    };

    int amountOfUpdated = await dataBase.update(
      "usuarios",
        userData,
        where: "id = ?",
        whereArgs: [userId]
    );

  }

  @override
  Widget build(BuildContext context) {

    _insert();

    return Container();

  }

}