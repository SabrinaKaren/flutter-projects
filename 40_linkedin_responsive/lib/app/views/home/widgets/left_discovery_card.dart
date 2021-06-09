/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class LeftDiscoveryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Row _getRow(String type, String text) {
      return Row(
        children: [
          Image.asset(type == 'people' ? 'assets/people_icon_01.png' : 'assets/tag_icon_01.png', height: 17, color: Colors.grey[600]),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }

    Padding _firstSection = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recentes',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          _getRow('people', 'Instituto de Arquitetos do Brasil'),
          const SizedBox(height: 5),
          _getRow('tag', 'data'),
          const SizedBox(height: 5),
          _getRow('tag', 'future'),
          const SizedBox(height: 5),
          _getRow('tag', 'gender'),
          const SizedBox(height: 5),
          _getRow('tag', 'bigdata'),
        ],
      ),
    );

    Padding _secondSection = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grupos',
            style: TextStyle(
              color: Color(0xff0A7BCE),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          _getRow('people', 'Instituto de Arquitetos do Brasil'),
          const SizedBox(height: 5),
          _getRow('people', 'Unica CRM/IT Professionals'),
          const SizedBox(height: 5),
          _getRow('people', 'IBM Unica NetInsight'),
          const SizedBox(height: 5),
          MouseRegion(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exibir mais',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
              onTap: () => print('Exibir mais'),
            ),
            cursor: SystemMouseCursors.click,
          ),
        ],
      ),
    );

    Padding _thirdSection = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            child: GestureDetector(
              child: Text(
                'Eventos',
                style: TextStyle(
                  color: Color(0xff0A7BCE),
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => print('Eventos'),
            ),
            cursor: SystemMouseCursors.click,
          ),
          MouseRegion(
            child: GestureDetector(
              child: Icon(Icons.add, color: Colors.grey[600]),
              onTap: () => print('add'),
            ),
            cursor: SystemMouseCursors.click,
          ),
        ],
      ),
    );

    Padding _fourthSection = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hashtags seguidas',
            style: TextStyle(
              color: Color(0xff0A7BCE),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          _getRow('tag', 'data'),
          const SizedBox(height: 5),
          _getRow('tag', 'future'),
          const SizedBox(height: 5),
          _getRow('tag', 'gender'),
          const SizedBox(height: 5),
          MouseRegion(
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exibir mais',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
              onTap: () => print('Exibir mais'),
            ),
            cursor: SystemMouseCursors.click,
          ),
        ],
      ),
    );

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[400]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _firstSection,
          _secondSection,
          _thirdSection,
          _fourthSection,
          Divider(),
          MouseRegion(
            child: GestureDetector(
              child: Center(
                child: Text(
                  'Descubra mais',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onTap: () => print('Descubra mais'),
            ),
            cursor: SystemMouseCursors.click,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );

  }

}