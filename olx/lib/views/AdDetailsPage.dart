/*
  Sabrina Karen
*/

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/data/AdData.dart';
import 'package:olx/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetailsPage extends StatefulWidget {

  AdData ad;
  AdDetailsPage(this.ad);

  @override
  _AdDetailsPageState createState() => _AdDetailsPageState();

}

class _AdDetailsPageState extends State<AdDetailsPage> {

  AdData _ad;

  List<Widget> _getPhotosList() {

    List<String> listOfUrlPhotos = _ad.photos;

    return listOfUrlPhotos.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.fitWidth)
        ),
      );
    }).toList();

  }

  _callPhone(String phone) async {

    if (await canLaunch("tel:$phone")) {
      await launch("tel:$phone");
    } else {

    }

  }

  @override
  void initState() {
    super.initState();
    _ad = widget.ad;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Anúncio"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Carousel(
                  images: _getPhotosList(),
                  dotSize: 8,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  autoplay: false,
                  dotIncreasedColor: defaultTheme.primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "R\$ ${_ad.price}",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: defaultTheme.primaryColor
                      ),
                    ),
                    Text(
                      "${_ad.title}",
                      style:
                          TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Text(
                      "Descrição",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_ad.description}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Text(
                      "Contato",
                      style:
                          TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 66),
                      child: Text(
                        "${_ad.phone}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GestureDetector(
              child: Container(
                child: Text(
                  "Ligar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: defaultTheme.primaryColor,
                    borderRadius: BorderRadius.circular(30)
                ),
              ),
              onTap: () {
                _callPhone(_ad.phone);
              },
            ),
          )
        ],
      ),
    );

  }

}