import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class UploadTeacherPage extends StatefulWidget {
  UploadTeacherPage({Key? key}) : super(key: key);

  @override
  _UploadTeacherPageState createState() => _UploadTeacherPageState();
}

class _UploadTeacherPageState extends State<UploadTeacherPage> {
  final DatabaseReference _messagesRef =
      FirebaseDatabase(databaseURL: 'https://moove-dance-studio-default-rtdb.europe-west1.firebasedatabase.app/')
          .reference();

  String dropdownValue = 'Dance Class';
  var teacherValue = 'Marco';
  var danceClassTypeValue = DanceClassType.hiphop;
  var danceClassLevelValue = DanceClassLevel.beginner;
  var _timeValue = DateTime.now();
  var _imageUrl;
  final _timeController = TextEditingController(
    text: DateTime.now().toString(),
  );
  final _durationController = TextEditingController(text: "60");
  final _focusDuration = FocusNode();

  final _teacherNameController = TextEditingController();
  final _focusTeacherName = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AppHeader(
            title: 'Upload',
          ),
          SliverToBoxAdapter(
              child: Material(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: SizeConstants.large, vertical: SizeConstants.big),
              child: Column(
                children: [
                  DropdownButton(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: ['Dance Class', 'Teacher']
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: SizeConstants.normal,
                  ),
                  if (dropdownValue == "Dance Class") _buildDanceClassScaffold(),
                  if (dropdownValue == "Teacher") _buildTeacherScaffold(),
                  SizedBox(
                    height: SizeConstants.normal,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            _messagesRef.child(dropdownValue).push().set(
                                  DanceClass(
                                    teacher: Teacher(teacherName: teacherValue, teacherImageUrl: null),
                                    type: danceClassTypeValue,
                                    level: danceClassLevelValue,
                                    time: DateTime.now(),
                                    durationInMin: 10,
                                  ).toJson(),
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
  }

  _buildDanceClassScaffold() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Teacher: '),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: SizeConstants.large),
                child: DropdownButton(
                  isExpanded: true,
                  value: teacherValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      teacherValue = newValue!;
                    });
                  },
                  items: ['Marco', 'Lukas']
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
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

  Widget _buildTeacherScaffold() {
    return Column(
      children: [
        Row(
          children: [
            Text('Name: '),
            Expanded(
              child: TextFormField(
                controller: _teacherNameController,
                focusNode: _focusTeacherName,
                decoration: InputDecoration(
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text("Image: "),
            if (_imageUrl != null) Text('Image Selected'),
            ElevatedButton(
              child: Text(
                _imageUrl != null ? 'Select Other' : 'Select',
              ),
              onPressed: () {
                _navigateAndDisplayImageSelectorPage(context);
              },
            )
          ],
        )
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

  _navigateAndDisplayImageSelectorPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => TeacherImageSelectionBloc(
            storage: FirebaseStorage.instance,
          )..add(TeacherImageSelectionStarted()),
          child: ImageSelectionPage(),
        ),
      ),
    );
    setState(() {
      _imageUrl = result;
    });
  }
}
