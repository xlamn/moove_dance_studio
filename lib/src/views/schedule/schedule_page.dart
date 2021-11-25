import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:weekday_selector/weekday_selector.dart';

// ignore: must_be_immutable
class SchedulePage extends StatelessWidget {
  SchedulePage({Key? key}) : super(key: key);

  var _currentWeek;
  var _currentDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<DanceClassBloc>(context).add(
            DanceClassFetched(
              currentDay: _currentDay,
              currentWeek: _currentWeek,
            ),
          );
          return Future.value(true);
        },
        edgeOffset: 220,
        child: CustomScrollView(
          slivers: <Widget>[
            AppHeader(
              title: 'Schedule',
              action: () => showUploadActions(context),
            ),
            _buildWeekSelection(context),
            _buildDaySelection(context),
            SliverToBoxAdapter(
              child: BlocBuilder<DanceClassBloc, DanceClassState>(builder: (context, state) {
                if (state is DanceClassFetchSuccess) {
                  return state.danceClasses.isEmpty
                      ? Container(
                          padding: EdgeInsets.all(SizeConstants.large),
                          child: Center(
                            child: Text(
                              'Seems like there are no classes on this day...',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        )
                      : RoundedContainer(
                          items: [
                            for (var danceClass in state.danceClasses)
                              _buildDanceClass(
                                context: context,
                                danceClass: danceClass,
                                withDivider: state.danceClasses.last != danceClass ? true : false,
                              ),
                          ],
                        );
                }
                if (state is DanceClassFetchInProgress) {
                  return Container(
                    padding: EdgeInsets.all(SizeConstants.large),
                    child: Center(
                      child: Text(
                        'Loading dance classes ...',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                }
                if (state is DanceClassFetchFailure) {
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekSelection(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<WeekSelectorBloc, WeekSelectorState>(
        builder: (context, state) {
          if (state is WeekChangedSuccess) {
            _currentWeek = state.selectedWeek;
            return Container(
              padding: EdgeInsets.only(
                top: SizeConstants.big,
                bottom: SizeConstants.mini,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_left_rounded,
                    ),
                    onPressed: () {
                      BlocProvider.of<WeekSelectorBloc>(context).add(
                        WeekChanged(
                          currentDay: _currentDay,
                          currentWeekNumber: state.selectedWeek,
                          isNextWeek: false,
                        ),
                      );
                    },
                  ),
                  Text(
                    '${DateFormat('dd.MM').format(state.selectedWeek.getDateByWeekNumber())} - ${DateFormat('dd.MM').format(state.selectedWeek.getDateByWeekNumber(start: false))}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_right_rounded,
                    ),
                    onPressed: () {
                      BlocProvider.of<WeekSelectorBloc>(context).add(
                        WeekChanged(
                          currentDay: _currentDay,
                          currentWeekNumber: state.selectedWeek,
                          isNextWeek: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildDaySelection(BuildContext context) {
    var values = List.filled(7, false);
    values.last = !values.last;

    return SliverToBoxAdapter(
      child: BlocConsumer<WeekDayBloc, WeekDayState>(
        listener: (context, state) {
          if (state is WeekDayChangedSuccess) {
            values = List.filled(7, false);
            final index = state.selectedDay % 7;
            values[index] = !values[index];
            _currentDay = index;
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              bottom: SizeConstants.big,
              top: SizeConstants.mini,
              left: SizeConstants.normal,
              right: SizeConstants.normal,
            ),
            child: WeekdaySelector(
              onChanged: (int day) {
                BlocProvider.of<WeekDayBloc>(context).add(
                  WeekDayChanged(
                    selectedDay: day,
                    currentWeek: _currentWeek,
                  ),
                );
              },
              values: values,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDanceClass({
    required BuildContext context,
    required DanceClass danceClass,
    required bool withDivider,
  }) {
    return Column(
      children: [
        GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: SizeConstants.large,
                horizontal: SizeConstants.normal,
              ),
              child: Row(
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: (danceClass.teacher.imageUrl != null)
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(danceClass.teacher.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          )
                        : BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).canvasColor,
                                spreadRadius: 0.25,
                                blurRadius: 5.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConstants.normal,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          danceClass.teacher.teacherName,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstants.small,
                          ),
                          child: Text(
                            danceClass.type.getTitle(),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context).textTheme.bodyText1?.color!.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text(
                          _getDanceClassTime(danceClass),
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DanceClassPage(
                    danceClass: danceClass,
                  ),
                ),
              );
            }),
        if (withDivider)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SizeConstants.mini,
            ),
            child: Divider(
              height: 1.0,
            ),
          ),
      ],
    );
  }

  void showUploadActions(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<TeacherSelectorBloc>(
                            create: (BuildContext context) => TeacherSelectorBloc(
                              database: FirebaseDatabase.instance,
                            )..add(
                                TeacherSelectorStarted(),
                              ),
                          ),
                          BlocProvider<UploadDanceClassBloc>(
                            create: (BuildContext context) => UploadDanceClassBloc(
                              database: FirebaseDatabase(databaseURL: Urls.retrieveDatabaseUrl()),
                            ),
                          ),
                        ],
                        child: UploadDanceClassPage(),
                      ),
                    ),
                  ),
                  child: Text('Dance Class'),
                ),
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider<UploadTeacherBloc>(
                        create: (BuildContext context) => UploadTeacherBloc(
                          database: FirebaseDatabase(databaseURL: Urls.retrieveDatabaseUrl()),
                        ),
                        child: UploadTeacherPage(),
                      ),
                    ),
                  ),
                  child: Text('Teacher'),
                ),
              ],
            ));
  }

  String _getDanceClassTime(DanceClass danceClass) {
    return "${DateFormat.Hm().format(danceClass.time).toString()} - ${DateFormat.Hm().format(danceClass.time.add(Duration(minutes: danceClass.durationInMin))).toString()}";
  }
}
