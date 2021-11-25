import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:moove_dance_studio/src/constants/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

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
            SliverToBoxAdapter(
              child: BlocBuilder<NewsPostBloc, NewsPostState>(builder: (context, state) {
                if (state is NewsPostFetchSuccess) {
                  return state.newsPosts.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(SizeConstants.large),
                          child: Center(
                            child: Text(
                              'Seems like there are no news ...',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            for (var newsPost in state.newsPosts)
                              _buildNewsPost(
                                context: context,
                                newsPost: newsPost,
                              ),
                          ],
                        );
                }
                if (state is NewsPostFetchInProgress) {
                  return Container(
                    padding: EdgeInsets.all(SizeConstants.large),
                    child: Center(
                      child: Text(
                        'Loading news ...',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                }
                if (state is NewsPostFetchFailure) {
                  return Container(
                    padding: EdgeInsets.all(SizeConstants.large),
                    child: Center(
                      child: Text(
                        'Something went wrong ...',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(SizeConstants.large),
                  child: Center(
                    child: Text(
                      'Nothing to show here ...',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }),
            )
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
                            timeago.format(newsPost.uploadDate),
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
                if (newsPost.imageUrl != null)
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(newsPost.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
}
