/*
  Sabrina Karen
*/

class DestinationData{

  String _street;
  String _number;
  String _city;
  String _neighborhood;
  String _cep;

  double _latitude;
  double _longitude;

  DestinationData();

  String get street => _street;

  set street(String value) {
    _street = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get neighborhood => _neighborhood;

  set neighborhood(String value) {
    _neighborhood = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

}