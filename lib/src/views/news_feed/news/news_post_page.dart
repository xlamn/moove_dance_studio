import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:timeago/timeago.dart' as timeago;

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
          padding: EdgeInsets.all(
            SizeConstants.large,
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
                      timeago.format(newsPost.uploadDate),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (newsPost.imageUrl != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: SizeConstants.small),
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(newsPost.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeConstants.small),
                child: Text(
                  newsPost.content ?? '',
                  style: TextStyle(
                    height: 1.5,
                  ),
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
