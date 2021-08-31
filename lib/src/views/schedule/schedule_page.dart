import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          AppHeader(
            title: 'Schedule',
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
    );
  }

  Widget _buildWeekSelection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
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
                onPressed: () {}),
            Text(
              "20.1. - 27.1",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_right_rounded,
                ),
                onPressed: null),
          ],
        ),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: danceClass.teacherImage,
                        fit: BoxFit.cover,
                      ),
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
                          danceClass.teacherName,
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
                            danceClass.type.getTitle(context),
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Text(
                          danceClass.time,
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

  final testDanceClasses = [
    DanceClass(
      teacherName: 'Tobi Auner',
      teacherImage: AssetImage('assets/coaches/tobi.jpg'),
      type: DanceClassType.hiphop,
      level: DanceClassLevel.starter,
      time: '17:30 - 18:30',
    ),
    DanceClass(
      teacherName: 'Dani Torrey-Cabello',
      teacherImage: AssetImage('assets/coaches/dani.jpg'),
      type: DanceClassType.popping,
      level: DanceClassLevel.beginner,
      time: '18:30 - 19:30',
    ),
    DanceClass(
      teacherName: 'Dani Torrey-Cabello',
      teacherImage: AssetImage('assets/coaches/dani.jpg'),
      type: DanceClassType.house,
      level: DanceClassLevel.intermediate,
      time: '19:30 - 20:30',
    ),
    DanceClass(
        teacherName: 'Tobi Auner',
        teacherImage: AssetImage('assets/coaches/tobi.jpg'),
        type: DanceClassType.hiphop,
        level: DanceClassLevel.masterclass,
        time: '20:30 - 22:30'),
  ];
}
