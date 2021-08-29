import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class AppHeader extends StatelessWidget {
  final String title;

  const AppHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).canvasColor,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.only(
          top: SizeConstants.large,
          bottom: SizeConstants.normal,
          right: SizeConstants.normal,
          left: SizeConstants.normal,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
