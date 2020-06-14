/*
  Sabrina Karen
 */

class UserData{

  String _userId;
  String _name;
  String _email;
  String _password;
  String _userType;

  UserData();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "nome" : this.name,
      "email" : this.email,
      "tipoUsuario" : this.userType,
    };

    return map;

  }

  String checkUserType(bool userType){
    return userType ? "motorista" : "passageiro";
  }

  String get userType => _userType;

  set userType(String value) {
    _userType = value;
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