/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PostItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final desktop = ResponsiveWrapper.of(context).isDesktop;

    Widget _posterIdentification = Padding(
      padding: EdgeInsets.fromLTRB(16, 14, 14, 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/my_profile_02.jpg'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'sabrina_karen_s',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.more_horiz_sharp,
              color: Colors.white,
            ),
            onTap: () => print('Clicou no more_horiz_sharp'),
          ),
        ],
      ),
    );

    Widget _postOptions = Padding(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.white,
            onPressed: () => print('Clicou no favorite_border'),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.messenger_outline),
            color: Colors.white,
            onPressed: () => print('Clicou no messenger_outline'),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () => print('Clicou no send'),
          ),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            color: Colors.white,
            onPressed: () => print('Clicou no bookmark_border'),
          ),
        ],
      ),
    );

    Widget _postReactions = Padding(
      padding: EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Curtido por silvia_karen e outras 300 pessoas',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'HÁ 1 HORA',
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: desktop ? 35 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _posterIdentification,
          Image.asset('assets/post_01.jpg'),
          _postOptions,
          _postReactions,
          if (desktop) ... [
            Divider(
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 0, 24),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Adicione um comentário...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text('Publicar'),
                  onPressed: () => print('Clicou em publicar'),
                ),
              ],
            ),
          ],
        ],
      ),
    );

  }

}