/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:responsive_01/app/pages/home/widgets/course_item.dart';
import 'package:responsive_01/app/shared/breakpoints.dart';

class CoursesSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (_, constraints) {

        return GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: constraints.maxWidth >= tabletBreakpoint ? 0 : 16),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CourseItem();
          },
        );

      },
    );

  }

}