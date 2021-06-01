/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class WebAppBarResponsiveContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {

          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.grey[500],
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pesquise alguma coisa aqui',
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: constraints.maxWidth >= 400,
                child: Row(
                  children: [
                    const SizedBox(width: 32),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Aprender'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: constraints.maxWidth >= 500,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {},
                      child: Text('Flutter'),
                    ),
                  ],
                ),
              ),
            ],
          );

        },
      ),
    );
  }

}