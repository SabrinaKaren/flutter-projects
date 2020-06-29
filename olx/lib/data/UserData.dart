/*
  Sabrina Karen
*/

class UserData {

  String _userId;
  String _name;
  String _email;
  String _password;

  UserData();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "idUsuario"   : this._userId,
      "nome"        : this.name,
      "email"       : this._password
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

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

}