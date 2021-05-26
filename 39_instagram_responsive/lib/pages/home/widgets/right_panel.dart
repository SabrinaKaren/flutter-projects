/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:instagram_responsive/pages/home/widgets/suggestion_item.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RightPanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _profileAndExit = Row(
      children: [
        CircleAvatar(
          radius: 29,
          backgroundImage: AssetImage('assets/my_profile_02.jpg'),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'sabrina_karen_s',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Sabrina Karen',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Text(
              'Sair',
              style: TextStyle(
                color: Color(0xFF0396F6),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            onTap: () => print('Clicou em sair'),
          ),
        ),
      ],
    );

    Widget _suggestionsAndSeeAll = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sugestões para você',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey[500],
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Text(
              'Ver tudo',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            onTap: () => print('Clicou em ver tudo'),
          ),
        ),
      ],
    );

    return ResponsiveVisibility(
      visible: false,
      visibleWhen: [
        Condition.largerThan(name: TABLET),
      ],
      child: Container(
        width: 300,
        margin: EdgeInsets.fromLTRB(35, 56, 20, 0),
        child: Column(
          children: [
            _profileAndExit,
            const SizedBox(height: 24),
            _suggestionsAndSeeAll,
            const SizedBox(height: 8),
            SuggestionItem(),
            SuggestionItem(),
            SuggestionItem(),
          ],
        ),
      ),
    );

  }

}