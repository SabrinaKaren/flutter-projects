/*
  Sabrina Karen
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/Data/UserData.dart';

class UserOfFirebase{

  static Future<FirebaseUser> getCurrentUser() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();

  }

  static Future<UserData> getUserLoggedInfo() async {

    FirebaseUser firebaseUser = await getCurrentUser();
    String userId = firebaseUser.uid;

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document(userId)
        .get();

    Map<String, dynamic> data = snapshot.data;
    String userType = data["tipoUsuario"];
    String email = data["email"];
    String name = data["nome"];

    UserData user = UserData();
    user.userId = userId;
    user.userType = userType;
    user.email = email;
    user.name = name;

    return user;

  }

  static updateLocationData(String requestid, double lat, double lon) async {

    Firestore db = Firestore.instance;

    UserData driver = await getUserLoggedInfo();
    driver.latitude = lat;
    driver.longitude = lon;

    db.collection("requisicoes")
        .document(requestid)
        .updateData({
      "motorista" : driver.toMap()
    });

  }

}