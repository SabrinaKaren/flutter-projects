/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:minhasanotacoes/helper/HelperAnnotation.dart';
import 'model/Annotation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  var _db = HelperAnnotation();
  List<Annotation> _annotations = List<Annotation>();

  _showRegistrationScreen( {Annotation annotation} ){

    String textSaveUpdate = "";
    if( annotation == null ){ // incluir
      _titleController.text = "";
      _descriptionController.text = "";
      textSaveUpdate = "Salvar";
    }else{ // atualizar
      _titleController.text = annotation.titulo;
      _descriptionController.text = annotation.descricao;
      textSaveUpdate = "Atualizar";
    }

    showDialog(
        context: context,
        builder: (context){
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("$textSaveUpdate anotação"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: "Título",
                        hintText: "Digite o título"
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                        labelText: "Descrição",
                        hintText: "Digite uma descrição"
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancelar")
                ),
                FlatButton(
                    onPressed: (){
                      _saveUpdateAnnotation(annotationSelected: annotation);
                      Navigator.pop(context);
                    },
                    child: Text(textSaveUpdate)
                )
              ],
            ),
          );
        }
    );

  }

  _getAnnotations() async {

    List recoveredNotes = await _db.recoverAnnotations();

    List<Annotation> listTemp = List<Annotation>();
    for( var item in recoveredNotes ){

      Annotation annotation = Annotation.fromMap(item);
      listTemp.add(annotation);

    }

    setState(() {
      _annotations = listTemp;
    });
    listTemp = null;

  }

  _saveUpdateAnnotation( {Annotation annotationSelected} ) async {

    String title = _titleController.text;
    String desc = _descriptionController.text;

    if( annotationSelected == null ){ // incluir
      Annotation annotation = Annotation(title, desc, DateTime.now().toString() );
      int result = await _db.saveAnnotation(annotation);
    }else{ // atualizar
      annotationSelected.titulo = title;
      annotationSelected.descricao = desc;
      annotationSelected.data = DateTime.now().toString();
      int result = await _db.updateAnnotation(annotationSelected);
    }

    _titleController.clear();
    _descriptionController.clear();

    _getAnnotations();

  }

  _formateDate(String dateInString){

    initializeDateFormatting("pt_BR");

    var sdf = DateFormat.yMd("pt_BR");

    DateTime dateInDate = DateTime.parse(dateInString);
    String sdfDate = sdf.format(dateInDate);

    return sdfDate;

  }

  _deleteAnnotation(int id) async {
    await _db.deleteAnnotation(id);
    _getAnnotations();
  }

  @override
  void initState() {
    super.initState();
    _getAnnotations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotações"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _annotations.length,
                  itemBuilder: (context, index){

                    final item = _annotations[index];

                    return Card(
                      child: ListTile(
                        title: Text(item.titulo),
                        subtitle: Text("${_formateDate(item.data)} - ${item.descricao}") ,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                _showRegistrationScreen(annotation: item);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _deleteAnnotation(item.id);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
            _showRegistrationScreen();
          }
      ),
    );
  }

}