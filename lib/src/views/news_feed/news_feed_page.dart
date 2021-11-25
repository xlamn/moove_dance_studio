import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:moove_dance_studio/src/constants/constants.dart';

import 'news/news.dart';

class NewsFeedPage extends StatelessWidget {
  NewsFeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () => Future.value(true),
        edgeOffset: 220,
        child: CustomScrollView(
          slivers: <Widget>[
            AppHeader(
              title: 'News Feed',
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<UploadNewsPostBloc>(
                    create: (BuildContext context) => UploadNewsPostBloc(
                      database: FirebaseDatabase(
                        databaseURL: Urls.retrieveDatabaseUrl(),
                      ),
                    ),
                    child: UploadNewsPostPage(),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildNewsPost(
                    context: context,
                    newsPost: testNews[index],
                  );
                },
                childCount: testNews.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsPost({
    required BuildContext context,
    required NewsPost newsPost,
  }) {
    return RoundedContainer(
      verticalPadding: SizeConstants.mini,
      items: [
        GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.all(
                SizeConstants.big,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: SizeConstants.small),
                        child: Text(
                          newsPost.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
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
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConstants.large,
                ),
                Placeholder(
                  fallbackHeight: 75,
                  fallbackWidth: 75,
                )
              ]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsPostPage(
                    newsPost: newsPost,
                  ),
                ),
              );
            }),
      ],
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

  final testNews = [
    NewsPost(
      title: 'Neue Stundenpläne ab nächster Woche!',
      tags: [
        NewsPostTag(
          text: 'Classes',
          color: Colors.blue,
        )
      ],
      uploadDate: DateTime.utc(2020, 11, 5),
    ),
    NewsPost(
      title: 'Wir schließen vorübergehend wegen den Corona-Maßnahmen',
      tags: [
        NewsPostTag(
          text: 'News',
          color: Colors.orange,
        ),
        NewsPostTag(
          text: 'WICHTIG',
          color: Colors.red,
        ),
      ],
      uploadDate: DateTime.utc(2020, 11, 3),
    ),
    NewsPost(
      title: 'Online-Classes über unsere Instagram Seite',
      tags: [
        NewsPostTag(
          text: 'Classes',
          color: Colors.blue,
        ),
      ],
      uploadDate: DateTime.utc(2020, 11, 1),
    ),
    NewsPost(
      title: 'Neue Pullover und T-Shirts im Angebot! Schnell zugreifen!',
      tags: [
        NewsPostTag(
          text: 'Merchandise',
          color: Colors.green,
        )
      ],
      uploadDate: DateTime.utc(2020, 10, 20),
    ),
    NewsPost(
      title: 'Moove App geht in die Beta',
      tags: [
        NewsPostTag(
          text: 'News',
          color: Colors.orange,
        ),
      ],
      uploadDate: DateTime.utc(2020, 9, 3),
    ),
  ].reversed.toList();
}
