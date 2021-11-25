import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class UploadTeacherPage extends StatefulWidget {
  UploadTeacherPage({Key? key}) : super(key: key);

  @override
  _UploadTeacherPageState createState() => _UploadTeacherPageState();
}

class _UploadTeacherPageState extends State<UploadTeacherPage> {
  String? _imageUrl;

  final _teacherNameController = TextEditingController();
  final _focusTeacherName = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadTeacherBloc, UploadTeacherState>(listener: (context, state) {
      if (state is UploadTeacherSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Teacher successfully uploaded.'),
          ),
        );
        Navigator.of(context).pop();
      }
      if (state is UploadTeacherFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload Teacher.'),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is UploadTeacherInProgress) {
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
              title: 'New Teacher',
            ),
            SliverToBoxAdapter(
                child: Material(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.large,
                  vertical: SizeConstants.big,
                ),
                child: Column(
                  children: [
                    _buildTeacherForm(),
                    SizedBox(
                      height: SizeConstants.big,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<UploadTeacherBloc>(context).add(
                                TeacherUploaded(
                                  teacher: Teacher(
                                    teacherName: _teacherNameController.value.text,
                                    imageUrl: _imageUrl,
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

  Widget _buildTeacherForm() {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: (_imageUrl != null)
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_imageUrl!),
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
            child: (_imageUrl != null) ? SizedBox.shrink() : Icon(Icons.add),
          ),
          onTap: () {
            _navigateAndDisplayImageSelectorPage(context);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.normal,
          ),
        ),
        Container(
            padding: EdgeInsets.only(
              right: SizeConstants.normal,
            ),
            child: Text('Name: ')),
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
    );
  }

  void _navigateAndDisplayImageSelectorPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => ImageSelectionBloc(
            storage: FirebaseStorage.instance,
            reference: 'teacher',
          )..add(ImageSelectionStarted()),
          child: ImageSelectionPage(
            reference: 'teacher',
          ),
        ),
      ),
    );
    setState(() {
      _imageUrl = result;
    });
  }
}
