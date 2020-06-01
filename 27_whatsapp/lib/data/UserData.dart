/*
  Sabrina Karen
*/

class UserData{

  String _idUsuario;
  String _name;
  String _email;
  String _password;
  String _imageUrl;

  UserData();

  String get imageUrl => _imageUrl;

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : this.name,
      "email" : this.email
    };

    return map;

  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}