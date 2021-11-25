import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class UploadNewsPostPage extends StatefulWidget {
  UploadNewsPostPage({Key? key}) : super(key: key);

  @override
  _UploadNewsPostPageState createState() => _UploadNewsPostPageState();
}

class _UploadNewsPostPageState extends State<UploadNewsPostPage> {
  final _titleController = TextEditingController();
  final _focusTitle = FocusNode();
  final _contentController = TextEditingController();
  final _focusContent = FocusNode();
  var _imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadNewsPostBloc, UploadNewsPostState>(listener: (context, state) {
      if (state is UploadNewsPostSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('News Post successfully uploaded.'),
          ),
        );
        Navigator.of(context).pop();
      }
      if (state is UploadNewsPostFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload News Post.'),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is UploadNewsPostInProgress) {
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
              title: 'New \nNews Post',
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
                    _buildNewsPostForm(),
                    SizedBox(
                      height: SizeConstants.normal,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              right: SizeConstants.normal,
                            ),
                            child: Text('Content: ')),
                        Expanded(
                          child: TextFormField(
                            controller: _contentController,
                            focusNode: _focusContent,
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
                    SizedBox(
                      height: SizeConstants.normal,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              BlocProvider.of<UploadNewsPostBloc>(context).add(
                                NewsPostUploaded(
                                  newsPost: NewsPost(
                                    title: _titleController.value.text,
                                    tags: [NewsPostTag(color: Colors.orange, text: 'News')],
                                    imageUrl: _imageUrl,
                                    content: _contentController.value.text,
                                    uploadDate: DateTime.now(),
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

  Widget _buildNewsPostForm() {
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
            controller: _titleController,
            focusNode: _focusTitle,
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
            reference: 'newsPost',
          )..add(ImageSelectionStarted()),
          child: ImageSelectionPage(
            reference: 'newsPost',
          ),
        ),
      ),
    );
    setState(() {
      _imageUrl = result;
    });
  }
}
