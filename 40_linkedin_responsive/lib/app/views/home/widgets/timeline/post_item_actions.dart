/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PostItemActions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveWrapper.of(context).isMobile;

    Padding _mobileActions = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/like_icon_02.png', height: 20, color: Colors.grey[600]),
                  Text(
                    'Gostei',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onTap: () => print('Gostei'),
            ),
            cursor: SystemMouseCursors.click,
          ),
          MouseRegion(
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/comment_icon_01.png', height: 20, color: Colors.grey[600]),
                  Text(
                    'Comentar',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onTap: () => print('Comentar'),
            ),
            cursor: SystemMouseCursors.click,
          ),
          MouseRegion(
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/share_icon_01.png', height: 20, color: Colors.grey[600]),
                  Text(
                    'Compartilhar',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onTap: () => print('Compartilhar'),
            ),
            cursor: SystemMouseCursors.click,
          ),
          MouseRegion(
            child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/submit_icon_01.png', height: 20, color: Colors.grey[600]),
                  Text(
                    'Enviar',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onTap: () => print('Enviar'),
            ),
            cursor: SystemMouseCursors.click,
          ),
        ],
      ),
    );

    Row _webTabletActions = Row(
      children: [
        MouseRegion(
          child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/like_icon_02.png', height: 25, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  'Gostei',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () => print('Gostei'),
          ),
          cursor: SystemMouseCursors.click,
        ),
        const SizedBox(width: 20),
        MouseRegion(
          child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/comment_icon_01.png', height: 25, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  'Comentar',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () => print('Comentar'),
          ),
          cursor: SystemMouseCursors.click,
        ),
        const SizedBox(width: 20),
        MouseRegion(
          child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/share_icon_01.png', height: 25, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  'Compartilhar',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () => print('Compartilhar'),
          ),
          cursor: SystemMouseCursors.click,
        ),
        const SizedBox(width: 20),
        MouseRegion(
          child: GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/submit_icon_01.png', height: 25, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            onTap: () => print('Enviar'),
          ),
          cursor: SystemMouseCursors.click,
        ),
      ],
    );

    return Visibility(
      visible: isMobile,
      child: _mobileActions,
      replacement: _webTabletActions,
    );

  }

}