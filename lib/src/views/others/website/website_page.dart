import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class WebsitePage extends StatelessWidget {
  const WebsitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalWebView(
      title: 'Moove Academy',
      url: 'https://www.moove-dance.de',
    );
  }
}
