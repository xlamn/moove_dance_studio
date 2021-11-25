import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class NewsPostPage extends StatelessWidget {
  final NewsPost newsPost;

  const NewsPostPage({
    Key? key,
    required this.newsPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.big,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeConstants.small),
                child: Text(
                  newsPost.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeConstants.small),
                child: Row(
                  children: [
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: SizeConstants.small,
                        direction: Axis.horizontal,
                        children: _buildTags(newsPost.tags)),
                    if (newsPost.tags.isNotEmpty)
                      SizedBox(
                        width: SizeConstants.small,
                      ),
                    Text(
                      'vor 2 Std',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeConstants.small),
                child: Placeholder(
                  fallbackHeight: 200,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeConstants.small),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: TextStyle(height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTags(List<NewsPostTag> tags) {
    final tagWidget = <Widget>[];
    for (final tag in tags) {
      tagWidget.add(Tag(
        tagText: tag.text,
        color: tag.color,
      ));
    }
    return tagWidget;
  }
}
