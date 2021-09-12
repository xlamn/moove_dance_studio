import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: SizeConstants.small),
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
                                  children: newsPost.tags),
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

  final testNews = [
    NewsPost(
      title: 'Neue Stundenpläne ab nächster Woche!',
      tags: [
        Tag(
          tagText: 'Classes',
          color: Colors.blue,
        )
      ],
    ),
    NewsPost(
      title: 'Wir schließen vorübergehend wegen den Corona-Maßnahmen',
      tags: [
        Tag(
          tagText: 'News',
        ),
        Tag(
          tagText: 'WICHTIG',
          color: Colors.red,
        ),
      ],
    ),
    NewsPost(
      title: 'Online-Classes über unsere Instagram Seite',
      tags: [
        Tag(
          tagText: 'Classes',
          color: Colors.blue,
        ),
      ],
    ),
    NewsPost(
      title: 'Neue Pullover und T-Shirts im Angebot! Schnell zugreifen!',
      tags: [
        Tag(
          tagText: 'Merchandise',
          color: Colors.green,
        )
      ],
    ),
    NewsPost(
      title: 'Moove App geht in die Beta',
      tags: [
        Tag(
          tagText: 'News',
        ),
      ],
    ),
  ].reversed.toList();
}
