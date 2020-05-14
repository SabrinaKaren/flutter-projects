/*
  Sabrina Karen
*/

class ConversationData{

  String _name;
  String _message;
  String _photoPath;

  ConversationData(this._name, this._message, this._photoPath);

  String get photoPath => _photoPath;

  set photoPath(String value) {
    _photoPath = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

}