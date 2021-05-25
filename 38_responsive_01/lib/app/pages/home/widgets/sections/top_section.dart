/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_01/app/custom_widgets/custom_search_field.dart';
import 'package:responsive_01/app/shared/breakpoints.dart';

class TopSection extends StatelessWidget {

  Widget _webTopSection = AspectRatio(
    aspectRatio: 3.2,
    child: Stack(
      children: [
        AspectRatio(
          aspectRatio: 3.4,
          child: Image.asset(
            'assets/top_section_01.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 50,
          top: 50,
          child: Card(
            color: Colors.black,
            elevation: 8,
            child: Container(
              width: 450,
              padding: EdgeInsets.all(22),
              child: Column(
                children: [
                  Text(
                    'Aprenda Flutter com este curso',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bora aprender Flutter com a professora Sabrina Karen! Curso por apenas R\$ 22,90. Qualidade garantida.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomSearchField(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _tabletTopSection = SizedBox(
    height: 320,
    child: Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.asset(
            'assets/top_section_01.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Card(
            color: Colors.black,
            elevation: 8,
            child: Container(
              width: 350,
              padding: EdgeInsets.all(22),
              child: Column(
                children: [
                  Text(
                    'Aprenda Flutter com este curso',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bora aprender Flutter com a professora Sabrina Karen! Curso por apenas R\$ 22,90. Qualidade garantida.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomSearchField(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _mobileTopSection = Column(
    children: [
      AspectRatio(
        aspectRatio: 3.4,
        child: Image.asset(
          'assets/top_section_01.jpg',
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aprenda Flutter com este curso',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bora aprender Flutter com a professora Sabrina Karen! Curso por apenas R\$ 22,90. Qualidade garantida.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            CustomSearchField(),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {

        final maxWidth = constraints.maxWidth;

        return Visibility(
          visible: maxWidth >= tabletBreakpoint,
          child: _webTopSection,
          replacement: Visibility(
            visible: maxWidth >= mobileBreakpoint,
            child: _tabletTopSection,
            replacement: _mobileTopSection,
          ),
        );

      },
    );

  }

}