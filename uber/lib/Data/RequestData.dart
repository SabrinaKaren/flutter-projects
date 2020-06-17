/*
  Sabrina Karen
*/

import 'package:uber/Data/DestinationData.dart';
import 'package:uber/Data/UserData.dart';

class RequestData{

  String _id;
  String _status;
  UserData _passenger;
  UserData _driver;
  DestinationData _destination;

  RequestData();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> passengerInfo = {
      "nome" : this.passenger.name,
      "email" : this.passenger.email,
      "tipoUsuario" : this.passenger.userType,
      "idUsuario" : this.passenger.userId,
    };

    Map<String, dynamic> destinationInfo = {
      "rua" : this.destination.street,
      "numero" : this.destination.number,
      "bairro" : this.destination.neighborhood,
      "cep" : this.destination.cep,
      "latitude" : this.destination.latitude,
      "longitude" : this.destination.longitude,
    };

    Map<String, dynamic> requestInfo = {
      "status" : this.status,
      "passageiro" : passengerInfo,
      "motorista" : null,
      "destino" : destinationInfo,
    };

    return requestInfo;

  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  UserData get passenger => _passenger;

  set passenger(UserData value) {
    _passenger = value;
  }

  UserData get driver => _driver;

  set driver(UserData value) {
    _driver = value;
  }

  DestinationData get destination => _destination;

  set destination(DestinationData value) {
    _destination = value;
  }

}