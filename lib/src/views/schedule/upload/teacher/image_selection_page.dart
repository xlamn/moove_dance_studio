import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class ImageSelectionPage extends StatelessWidget {
  const ImageSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<TeacherImageSelectionBloc, TeacherImageSelectionState>(
          builder: (context, state) {
            if (state is TeacherImagesFetchSuccess) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
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
                itemCount: state.imageUrls.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              );
            } else if (state is TeacherImagesFetchInProgress) {
              return Container(
                padding: const EdgeInsets.all(
                  SizeConstants.big,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is TeacherImagesFetchFailure) {
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
}
