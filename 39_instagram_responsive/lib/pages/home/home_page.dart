/*
  Sabrina Karen
*/

import 'package:flutter/material.dart';
import 'package:instagram_responsive/pages/home/widgets/responsive_app_bar.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 52), child: ResponsiveAppBar()),
    );
  }

}