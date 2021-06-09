/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:linkedin_responsive/app/models/post_model.dart';
import 'package:linkedin_responsive/app/models/profile_identification_model.dart';
import 'package:linkedin_responsive/app/views/home/widgets/timeline/post_item_actions.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PostItem extends StatefulWidget {
  final PostModel postObject;
  PostItem({
    this.postObject,
  });
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  bool _showAllText;

  @override
  void initState() {
    super.initState();
    _showAllText = false;
  }

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveWrapper.of(context).isMobile;

    MouseRegion _reactions = MouseRegion(
      child: GestureDetector(
        child: Row(
          children: [
            Image.asset('assets/like_icon_01.png', height: 19),
            const SizedBox(width: 5),
            Image.asset('assets/applause_icon_01.png', height: 19),
            const SizedBox(width: 5),
            Image.asset('assets/brilliant_icon_01.png', height: 19),
            const SizedBox(width: 5),
            MouseRegion(
              child: InkWell(
                child: Text(
                  '809',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () => print('Reações'),
              ),
              cursor: SystemMouseCursors.click,
            ),
            const SizedBox(width: 5),
            Text(
              '•',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 5),
            MouseRegion(
              child: InkWell(
                child: Text(
                  '18 comentários',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () => print('Comentários'),
              ),
              cursor: SystemMouseCursors.click,
            ),
          ],
        ),
        onTap: () => print('Reações'),
      ),
      cursor: SystemMouseCursors.click,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[400]),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ProfileIdentificationModel().buildProfileWidget(widget.postObject.profileIdentificationObject, isMobile),
                  const SizedBox(height: 20),
                  Text(
                    widget.postObject.postText,
                    maxLines: _showAllText ? null : 2,
                  ),
                  Visibility(
                    visible: !_showAllText,
                    child: MouseRegion(
                      child: InkWell(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '...ver mais',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _showAllText = true;
                          });
                        },
                      ),
                      cursor: SystemMouseCursors.click,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(widget.postObject.postImg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  _reactions,
                  Divider(),
                  const SizedBox(height: 5),
                  PostItemActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}