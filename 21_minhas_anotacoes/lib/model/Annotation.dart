/*
  Sabrina Karen
*/

class Annotation{

  int id;
  String titulo;
  String descricao;
  String data;

  Annotation(this.titulo, this.descricao, this.data);

  Map toMap(){

    Map<String, dynamic> map = {
      "titulo" : this.titulo,
      "descricao" : this.descricao,
      "data" : this.data,
    };

    if( this.id != null ){
      map["id"] = this.id;
    }

    return map;

  }

  Annotation.fromMap(Map map){

    this.id = map["id"];
    this.titulo = map["titulo"];
    this.descricao = map["descricao"];
    this.data = map["data"];

  }

}