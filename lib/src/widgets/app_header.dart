import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? action;

  const AppHeader({
    Key? key,
    required this.title,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (action != null && user != null)
              IconButton(
                iconSize: SizeConstants.large,
                icon: const Icon(Icons.add_circle),
                onPressed: action,
              ),
          ],
        ),
      ),
    );
  }
}
