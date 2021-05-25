/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_01/app/shared/breakpoints.dart';

class AdvantagesSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _buildHorizontalAdvantage(String title, String subTitle) {
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

    Widget _buildVerticalAdvantage(String title, String subTitle) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 45,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subTitle,
            style: TextStyle(
                color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget _notMobileAdvantagesSection = Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: 16,
        spacing: 8,
        children: [
          _buildHorizontalAdvantage('+ 45.000 alunos', 'Didática garantida'),
          _buildHorizontalAdvantage('+ 45.000 alunos', 'Didática garantida'),
          _buildHorizontalAdvantage('+ 45.000 alunos', 'Didática garantida'),
        ],
      ),
    );

    Widget _mobileAdvantagesSection = Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(child: _buildVerticalAdvantage('+ 45.000 alunos', 'Didática garantida')),
          const SizedBox(width: 4),
          Expanded(child: _buildVerticalAdvantage('+ 45.000 alunos', 'Didática garantida')),
          const SizedBox(width: 4),
          Expanded(child: _buildVerticalAdvantage('+ 45.000 alunos', 'Didática garantida')),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (_, constraints) {
        return Visibility(
          visible: constraints.maxWidth >= mobileBreakpoint,
          child: _notMobileAdvantagesSection,
          replacement: _mobileAdvantagesSection,
        );
      },
    );

  }

}