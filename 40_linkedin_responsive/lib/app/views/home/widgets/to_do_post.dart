/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';

class ToDoPost extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _searchBox = Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[400]),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      child: TextField(
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText: 'Começar publicação',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey[400]),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/my_profile_01.jpg'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _searchBox,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MouseRegion(
                child: GestureDetector(
                  child: Row(
                    children: [
                      Image.asset('assets/photo_icon_01.png', width: 25),
                      const SizedBox(width: 4),
                      Text(
                        'Foto',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => print('Postar foto'),
                ),
                cursor: SystemMouseCursors.click,
              ),
              MouseRegion(
                child: GestureDetector(
                  child: Row(
                    children: [
                      Image.asset('assets/video_icon_01.png', width: 25),
                      const SizedBox(width: 4),
                      Text(
                        'Vídeo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => print('Postar foto'),
                ),
                cursor: SystemMouseCursors.click,
              ),
              MouseRegion(
                child: GestureDetector(
                  child: Row(
                    children: [
                      Image.asset('assets/event_icon_01.png', width: 25),
                      const SizedBox(width: 4),
                      Text(
                        'Evento',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => print('Postar foto'),
                ),
                cursor: SystemMouseCursors.click,
              ),
              MouseRegion(
                child: GestureDetector(
                  child: Row(
                    children: [
                      Image.asset('assets/article_icon_01.png', width: 25),
                      const SizedBox(width: 4),
                      Text(
                        'Escrever artigo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => print('Postar foto'),
                ),
                cursor: SystemMouseCursors.click,
              ),
            ],
          ),
        ],
      ),
    );

  }

}