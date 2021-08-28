import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:url_launcher/url_launcher.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 75,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            titlePadding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 40,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'Location',
          ),
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'Website',
            page: WebsitePage(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 50,
          ),
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'Privacy',
          ),
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'User Conditions',
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 50,
          ),
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'Contact',
          ),
        ),
        SliverToBoxAdapter(
          child: listItem(
            context: context,
            title: 'Feedback',
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: SizeConstants.large,
          ),
        ),
        SliverToBoxAdapter(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: SizeConstants.normal),
              child: Column(
                children: [
                  Text(
                    'Moove Academy\nMachtlfinger Str. 10\n81379 München',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            onTap: () => _launchMapsUrl(
              lat: 48.09697179346367,
              lon: 11.513520750884151,
            ),
          ),
        ),
      ],
    );
  }

  Widget listItem({
    required BuildContext context,
    required String title,
    Widget? page,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.large,
          vertical: SizeConstants.normal,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.arrow_right,
            ),
          ],
        ),
      ),
      onTap: page != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              )
          : () {},
    );
  }

  void _launchMapsUrl({double? lat, double? lon}) async {
    var url = '';
    if (Platform.isIOS) {
      url = 'https://maps.apple.com/?q=$lat,$lon';
    } else {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
