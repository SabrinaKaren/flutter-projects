/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:olx/data/AdData.dart';

class AdItem extends StatelessWidget {

  AdData ad;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  AdItem({@required this.ad, this.onTapItem, this.onPressedRemover});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                  ad.photos[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ad.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("R\$ ${ad.price} "),
                    ],
                  ),
                ),
              ),
              if (this.onPressedRemover != null)
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: Colors.red,
                    padding: EdgeInsets.all(10),
                    onPressed: this.onPressedRemover,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

  }

}