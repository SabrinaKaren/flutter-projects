/*
  Author: Sabrina Karen
*/

import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Empresa"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset("images/detalhe_empresa.png"),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Sobre a empresa",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                      "Lorem habitasse quis quisque lacus auctor felis sagittis ut, ac nullam rhoncus netus vel aenean vehicula, ad facilisis a nullam mattis nam phasellus. congue lacinia per viverra vivamus rhoncus libero mauris tempus, iaculis pulvinar elementum elit tincidunt donec rhoncus netus, fusce pretium sociosqu posuere sodales suspendisse nullam. leo at scelerisque condimentum cursus lectus accumsan taciti blandit, ut pellentesque sit eros aenean curae ipsum, tortor blandit elit nisi est duis tempor. tellus posuere placerat torquent leo aenean, hac auctor dui volutpat etiam, tellus pellentesque porta nulla. vitae hendrerit netus id ut feugiat sem ac duis purus varius, feugiat posuere praesent etiam sodales consequat id morbi ornare, urna felis quam nunc sed ad cras at magna.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );

  }

}