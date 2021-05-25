/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class AdvantagesSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _buildAdvantage(String title, String subTitle) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 45,
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: 16,
        spacing: 8,
        children: [
          _buildAdvantage('+ 45.000 alunos', 'Didática garantida'),
          _buildAdvantage('+ 45.000 alunos', 'Didática garantida'),
          _buildAdvantage('+ 45.000 alunos', 'Didática garantida'),
        ],
      ),
    );

  }

}