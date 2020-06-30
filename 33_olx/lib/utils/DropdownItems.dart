/*
  Sabrina Karen
*/

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class DropdownItems {

  static List<DropdownMenuItem<String>> getStates(){

    List<DropdownMenuItem<String>> statesList = [];

    statesList.add(
        DropdownMenuItem(
          child: Text(
            "Região", style: TextStyle(
              color: Color(0xff9c27b0)
            ),
          ),
          value: null,
        )
    );

    for(var state in Estados.listaEstadosAbrv) {
      statesList.add(
          DropdownMenuItem(
            child: Text(state),
            value: state,
          )
      );
    }

    return statesList;

  }

  static List<DropdownMenuItem<String>> getCategories(){

    List<DropdownMenuItem<String>> categoriesList = [];

    categoriesList.add(
        DropdownMenuItem(
          child: Text(
            "Categoria", style: TextStyle(
              color: Color(0xff9c27b0)
            ),
          ),
          value: null,
        )
    );

    categoriesList.add(
        DropdownMenuItem(
          child: Text("Automóvel"),
          value: "auto",
        )
    );

    categoriesList.add(
        DropdownMenuItem(
          child: Text("Imóvel"),
          value: "imovel",
        )
    );

    categoriesList.add(
        DropdownMenuItem(
          child: Text("Eletrônicos"),
          value: "eletro",
        )
    );

    categoriesList.add(
        DropdownMenuItem(
          child: Text("Moda"),
          value: "moda",
        )
    );

    categoriesList.add(
        DropdownMenuItem(
          child: Text("Esportes"),
          value: "esportes",
        )
    );

    return categoriesList;

  }

}