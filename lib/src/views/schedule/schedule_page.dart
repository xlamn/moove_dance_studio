import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () => Future.value(true),
        edgeOffset: 220,
        child: CustomScrollView(
          slivers: <Widget>[
            AppHeader(
              title: 'Schedule',
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPage(),
                  ),
                );
              },
            ),
            _buildWeekSelection(context),
            _buildDaySelection(context),
            SliverToBoxAdapter(
              child: RoundedContainer(items: [
                for (var danceClass in testDanceClasses)
                  _buildDanceClass(
                    context: context,
                    danceClass: danceClass,
                    withDivider:
                        testDanceClasses.last != danceClass ? true : false,
                  ),
              ]),
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
                          currentWeekNumber: state.weekNumber,
                          isNextWeek: false,
                        ),
                      );
                    },
                  ),
                  Text(
                    '${DateFormat('dd.MM').format(state.weekNumber.getDateByWeekNumber())} - ${DateFormat('dd.MM').format(state.weekNumber.getDateByWeekNumber(start: false))}',
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
                          currentWeekNumber: state.weekNumber,
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
                BlocProvider.of<WeekDayBloc>(context)
                    .add(WeekDayChanged(selectedDay: day));
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
                    decoration: (danceClass.teacher.teacherImageUrl != null)
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: Image.memory(base64Decode(
                                      danceClass.teacher.teacherImageUrl!))
                                  .image,
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
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color!
                                  .withOpacity(0.8),
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

  String _getDanceClassTime(DanceClass danceClass) {
    return "${DateFormat.Hm().format(danceClass.time).toString()} - ${DateFormat.Hm().format(danceClass.time.add(Duration(minutes: danceClass.durationInMin))).toString()}";
  }

  final testDanceClasses = [
    DanceClass(
        teacher: Teacher(
          teacherName: 'Tobi Auner',
          teacherImageUrl: null,
        ),
        type: DanceClassType.hiphop,
        level: DanceClassLevel.starter,
        time: DateTime(2021, 05, 21, 17, 30),
        durationInMin: 60),
    DanceClass(
        teacher: Teacher(
          teacherName: 'Dani Torrey-Cabello',
          teacherImageUrl: null,
        ),
        type: DanceClassType.popping,
        level: DanceClassLevel.beginner,
        time: DateTime(2021, 05, 21, 18, 30),
        durationInMin: 60),
    DanceClass(
      teacher: Teacher(
        teacherName: 'Dani Torrey-Cabello',
        teacherImageUrl: null,
      ),
      type: DanceClassType.house,
      level: DanceClassLevel.intermediate,
      time: DateTime(2021, 05, 21, 19, 30),
      durationInMin: 60,
    ),
    DanceClass(
        teacher: Teacher(
          teacherName: 'Tobi Auner',
        ),
        type: DanceClassType.hiphop,
        level: DanceClassLevel.masterclass,
        time: DateTime(2021, 05, 21, 20, 30),
        durationInMin: 60),
  ];

  // Future<String> to64String() async {
  //     ByteData bytes = await rootBundle.load('assets/coaches/tobi.jpg');
  // var buffer = bytes.buffer;
  // return base64Encode(Uint8List.view(buffer));
  // }
}
