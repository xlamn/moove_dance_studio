import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class UploadDanceClassPage extends StatefulWidget {
  UploadDanceClassPage({Key? key}) : super(key: key);

  @override
  _UploadDanceClassPageState createState() => _UploadDanceClassPageState();
}

class _UploadDanceClassPageState extends State<UploadDanceClassPage> {
  var danceClassTypeValue = DanceClassType.hiphop;
  var danceClassLevelValue = DanceClassLevel.beginner;
  var _timeValue = DateTime.now();
  final _timeController = TextEditingController(
    text: DateTime.now().toString(),
  );
  final _durationController = TextEditingController(text: "60");
  final _focusDuration = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadDanceClassBloc, UploadDanceClassState>(listener: (context, state) {
      if (state is UploadDanceClassSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dance Class successfully uploaded.'),
          ),
        );
        Navigator.of(context).pop();
      }
      if (state is UploadDanceClassFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload Dance Class.'),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is UploadDanceClassInProgress) {
        return Container(
          padding: const EdgeInsets.all(
            SizeConstants.big,
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            AppHeader(
              title: 'New \nDance Class',
            ),
            SliverToBoxAdapter(
                child: Material(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: SizeConstants.large, vertical: SizeConstants.big),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConstants.normal,
                    ),
                    _buildDanceClassScaffold(),
                    SizedBox(
                      height: SizeConstants.normal,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<UploadDanceClassBloc>(context).add(
                                DanceClassUploaded(
                                  danceClass: DanceClass(
                                    teacher: BlocProvider.of<TeacherSelectorBloc>(context).state.selectedTeacher!,
                                    type: danceClassTypeValue,
                                    level: danceClassLevelValue,
                                    time: DateTime.now(),
                                    durationInMin: 10,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Upload',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      );
    });
  }

  Widget _buildDanceClassScaffold() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Teacher: '),
            ),
            BlocBuilder<TeacherSelectorBloc, TeacherSelectorState>(
              builder: (context, state) {
                if (state is TeachersFetchSuccess) {
                  return Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConstants.large,
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        value: state.selectedTeacher,
                        onChanged: (Teacher? newValue) {
                          BlocProvider.of<TeacherSelectorBloc>(context).add(
                            TeacherSelected(selectedTeacher: newValue!),
                          );
                        },
                        items: state.teachers
                            .map((value) => DropdownMenuItem(
                                  child: Text(value.teacherName),
                                  value: value,
                                ))
                            .toList(),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Type: '),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConstants.large),
                child: DropdownButton(
                  isExpanded: true,
                  value: danceClassTypeValue,
                  onChanged: (DanceClassType? newValue) {
                    setState(() {
                      danceClassTypeValue = newValue!;
                    });
                  },
                  items: [
                    DanceClassType.hiphop,
                    DanceClassType.house,
                    DanceClassType.locking,
                    DanceClassType.popping,
                    DanceClassType.female,
                  ]
                      .map((value) => DropdownMenuItem(
                            child: Text(value.getTitle()),
                            value: value,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Level: '),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConstants.large),
                child: DropdownButton(
                  isExpanded: true,
                  value: danceClassLevelValue,
                  onChanged: (DanceClassLevel? newValue) {
                    setState(() {
                      danceClassLevelValue = newValue!;
                    });
                  },
                  items: [
                    DanceClassLevel.beginner,
                    DanceClassLevel.starter,
                    DanceClassLevel.intermediate,
                    DanceClassLevel.masterclass,
                  ]
                      .map((value) => DropdownMenuItem(
                            child: Text(value.getTitle()),
                            value: value,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Date: '),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConstants.large),
                child: GestureDetector(
                  onTap: () => _showDatePicker(context),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _timeController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.2, child: Text('Duration: ')),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConstants.large),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _durationController,
                  focusNode: _focusDuration,
                  decoration: InputDecoration(
                    suffix: Text('min'),
                    hintText: "Duration",
                    errorBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (pickedDate) {
                          setState(() {
                            _timeValue = pickedDate;
                            _timeController.text = pickedDate.toString();
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ));
  }
}
