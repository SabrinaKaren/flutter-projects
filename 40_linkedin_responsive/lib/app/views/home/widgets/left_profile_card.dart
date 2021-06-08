/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class LeftProfileCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _cover = Container(
      height: 130,
      child: Stack(
        children: [
          Image.asset('assets/cover_01.jpg'),
          Positioned(
            left: 100,
            top: 30,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/my_profile_01.jpg'),
            ),
          ),
        ],
      ),
    );

    Column _firstSection = Column(
      children: [
        _cover,
        Text(
          'Sabrina Karen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Programadora Full-Stack na EloGroup',
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );

    Column _secondSection = Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quem viu seu perfil',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '110',
                style: TextStyle(
                  color: Color(0xff0A7BCE),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Viram sua publicação',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '389',
                style: TextStyle(
                  color: Color(0xff0A7BCE),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );

    Column _thirdSection = Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Acesse ferramentas e estatísticas exclusivas',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Image.asset('assets/premium_01.png', height: 15),
              const SizedBox(width: 4),
              Text(
                'Experimente Premium grátis',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );

    Padding _fourthSection = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Icon(Icons.bookmark, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 5),
          Text(
            'Meus itens',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
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
        children: [
          _firstSection,
          Divider(),
          _secondSection,
          Divider(),
          _thirdSection,
          Divider(),
          _fourthSection,
          const SizedBox(height: 10),
        ],
      ),
    );

  }

}