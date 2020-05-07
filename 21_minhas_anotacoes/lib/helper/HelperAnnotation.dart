/*
  Sabrina Karen
*/

import 'package:minhasanotacoes/model/Annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HelperAnnotation {

  static final String tableName = "anotacao";

  static final HelperAnnotation _helperAnnotation = HelperAnnotation._internal();
  Database _db;

  factory HelperAnnotation(){
    return _helperAnnotation;
  }

  HelperAnnotation._internal(){
  }

  get db async {

    if( _db != null ){
      return _db;
    }else{
      _db = await inicializateDB();
      return _db;
    }

  }

  _onCreate(Database db, int version) async {

    String sql = "CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, "
        "descricao TEXT, "
        "data DATETIME)";
    await db.execute(sql);

  }

  inicializateDB() async {

    final dataBasePath = await getDatabasesPath();
    final dataBaseLocal = join(dataBasePath, "banco_minhas_anotacoes.db");

    var db = await openDatabase(dataBaseLocal, version: 1, onCreate: _onCreate );
    return db;

  }

  Future<int> saveAnnotation(Annotation annotation) async {

    var dataBase = await db;
    int result = await dataBase.insert(tableName, annotation.toMap() );
    return result;

  }

  recoverAnnotations() async {

    var dataBase = await db;
    String sql = "SELECT * FROM $tableName ORDER BY data DESC ";
    List annotations = await dataBase.rawQuery(sql);
    return annotations;

  }

  Future<int> updateAnnotation(Annotation annotation) async {

    var dataBase = await db;
    return await dataBase.update(
        tableName,
        annotation.toMap(),
        where: "id = ?",
        whereArgs: [annotation.id]
    );

  }

  Future<int> deleteAnnotation(int id) async {

    var dataBase = await db;
    return await dataBase.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id]
    );

  }

}