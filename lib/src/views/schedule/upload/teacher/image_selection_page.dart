import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class ImageSelectionPage extends StatelessWidget {
  final String reference;

  const ImageSelectionPage({Key? key, required this.reference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<ImageSelectionBloc, ImageSelectionState>(
          builder: (context, state) {
            if (state is ImagesFetchSuccess) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  if (index == state.imageUrls.length) {
                    return GestureDetector(
                        child: SizedBox(
                          child: Icon(Icons.add_a_photo),
                        ),
                        onTap: () async {
                          final fileImage = await pickImage();
                          if (fileImage != null)
                            await FireStorage.uploadImageToFirebase(
                              context,
                              file: fileImage,
                              imageSelectionBloc: BlocProvider.of<ImageSelectionBloc>(context),
                              reference: reference,
                            );
                        });
                  }
                  return GestureDetector(
                      child: SizedBox(
                        child: Image.network(
                          state.imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(state.imageUrls[index]);
                      });
                },
                itemCount: state.imageUrls.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              );
            } else if (state is ImagesFetchInProgress) {
              return Container(
                padding: const EdgeInsets.all(
                  SizeConstants.big,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ImagesFetchFailure) {
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
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
