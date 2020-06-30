/*
  Sabrina Karen
*/

import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/data/AdData.dart';
import 'package:olx/utils/DropdownItems.dart';
import 'package:olx/views/widgets/StandardButton.dart';
import 'package:olx/views/widgets/StandardInput.dart';
import 'package:validadores/Validador.dart';

class NewAdPage extends StatefulWidget {
  @override
  _NewAdPageState createState() => _NewAdPageState();
}

class _NewAdPageState extends State<NewAdPage> {

  List<File> _photosList = List();
  List<DropdownMenuItem<String>> _statsList = List();
  List<DropdownMenuItem<String>> _categoriesList = List();
  final _formKey = GlobalKey<FormState>();
  AdData _ad;
  BuildContext _dialogContext;
  String _stateSelected;
  String _categorySelected;

  _getPhotoFromGalery() async {

    File photoSelected = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (photoSelected != null) {
      setState(() {
        _photosList.add(photoSelected);
      });
    }

  }

  _openDialog(BuildContext context) {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("Salvando anúncio...")
              ],
            ),
          );
        }
    );

  }

  _saveAd() async {

    _openDialog(_dialogContext);

    await _uploadPhotos();

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser loggedUser = await auth.currentUser();
    String loggedUserId = loggedUser.uid;

    Firestore db = Firestore.instance;
    db
        .collection("meus_anuncios")
        .document(loggedUserId)
        .collection("anuncios")
        .document(_ad.id)
        .setData(_ad.toMap())
        .then((_) {
      db
          .collection("anuncios")
          .document(_ad.id)
          .setData(_ad.toMap())
          .then((_) {
        Navigator.pop(_dialogContext);
        Navigator.pop(context);
      });
    });

  }

  Future _uploadPhotos() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference rootFolder = storage.ref();

    for (var photo in _photosList) {

      String photoName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference file = rootFolder.child("meus_anuncios").child(_ad.id).child(photoName);

      StorageUploadTask uploadTask = file.putFile(photo);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      _ad.photos.add(url);

    }

  }

  @override
  void initState() {
    super.initState();
    _loadDropdownItems();
    _ad = AdData.generateId();
  }

  _loadDropdownItems() {
    _categoriesList = DropdownItems.getCategories();
    _statsList = DropdownItems.getStates();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormField<List>(
                  initialValue: _photosList,
                  validator: (photos) {
                    if (photos.length == 0) {
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _photosList.length + 1,
                              itemBuilder: (context, index) {
                                if (index == _photosList.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getPhotoFromGalery();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.add_a_photo,
                                              size: 40,
                                              color: Colors.grey[100],
                                            ),
                                            Text(
                                              "Adicionar",
                                              style: TextStyle(color: Colors.grey[100]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (_photosList.length > 0) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Image.file(
                                                          _photosList[index]
                                                      ),
                                                      FlatButton(
                                                        child: Text("Excluir"),
                                                        textColor: Colors.red,
                                                        onPressed: () {
                                                          setState(() {
                                                            _photosList.removeAt(index);
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                            )
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            FileImage(_photosList[index]),
                                        child: Container(
                                          color: Color.fromRGBO(255, 255, 255, 0.4),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }
                          ),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text(
                              "[${state.errorText}]",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _stateSelected,
                          hint: Text("Estados"),
                          onSaved: (state) {
                            _ad.state = state;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          items: _statsList,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _stateSelected = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _categorySelected,
                          hint: Text("Categorias"),
                          onSaved: (category) {
                            _ad.category = category;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          items: _categoriesList,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _categorySelected = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: StandardInput(
                    hint: "Título",
                    onSaved: (title) {
                      _ad.title = title;
                    },
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: StandardInput(
                    hint: "Preço",
                    onSaved: (price) {
                      _ad.price = price;
                    },
                    type: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: StandardInput(
                    hint: "Telefone",
                    onSaved: (phone) {
                      _ad.phone = phone;
                    },
                    type: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(value);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: StandardInput(
                    hint: "Descrição (200 caracteres)",
                    onSaved: (description) {
                      _ad.description = description;
                    },
                    maxLines: null,
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .maxLength(200, msg: "Máximo de 200 caracteres")
                          .valido(value);
                    },
                  ),
                ),
                StandardButton(
                  text: "Cadastrar anúncio",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _dialogContext = context;
                      _saveAd();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

}