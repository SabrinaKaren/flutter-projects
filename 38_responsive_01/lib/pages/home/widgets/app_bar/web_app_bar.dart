/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_01/pages/home/widgets/app_bar/web_app_bar_responsive_content.dart';

class WebAppBar extends StatelessWidget {

  final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    primary: Colors.white,
    backgroundColor: Colors.black,
    minimumSize: Size(88, 38),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
        return BorderSide(
          color: Colors.white,
          width: 2,
        );
      },
    ),
  );

  final ButtonStyle elevatedButtonStyle = OutlinedButton.styleFrom(
    primary: Colors.black,
    backgroundColor: Colors.white,
    minimumSize: Size(88, 38),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  ).copyWith(
    side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return BorderSide(
            color: Colors.black,
            width: 1,
          );
        }
        return BorderSide();
      },
    ),
  );

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 72,
      title: Row(
        children: [
          Text(
            'Flutter',
          ),
          const SizedBox(width: 32),
          WebAppBarResponsiveContent(),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          const SizedBox(width: 24),
          SizedBox(
            height: 38,
            child: OutlinedButton(
              child: Text('Fazer login'),
              onPressed: () {},
              style: outlineButtonStyle,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              child: Text('Cadastre-se', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {},
              style: elevatedButtonStyle
            ),
          ),
        ],
      ),
    );

  }

}