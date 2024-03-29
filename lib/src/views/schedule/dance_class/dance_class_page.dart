import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class DanceClassPage extends StatelessWidget {
  final DanceClass danceClass;

  const DanceClassPage({
    Key? key,
    required this.danceClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditDanceClassBloc, EditDanceClassState>(listener: (context, state) {
      if (state is EditDanceClassDeleteSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dance Class successfully deleted.'),
          ),
        );
        Navigator.of(context).pop();
      }
      if (state is EditDanceClassDeleteFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete Dance Class.'),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is EditDanceClassDeleteInProgress) {
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
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/headers/header.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    actions: [
                      if (FirebaseAuth.instance.currentUser != null)
                        state is EditDanceClassStartSuccess
                            ? IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  BlocProvider.of<EditDanceClassBloc>(context).add(EditDanceClassUpdated());
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  BlocProvider.of<EditDanceClassBloc>(context).add(EditDanceClassStarted());
                                },
                              )
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConstants.big),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConstants.large,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConstants.mini),
                        child: Text(
                          danceClass.type.getTitle(),
                          style: TextStyle(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConstants.normal),
                        child: Text(
                          danceClass.type.getDescription(),
                          style: TextStyle(
                            fontSize: 16.0,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: SizeConstants.normal),
                        child: DanceClassLevelTag(
                          danceClass: danceClass,
                        ),
                      ),
                    ],
                  )),
            ),
            SliverToBoxAdapter(
              child: RoundedContainer(items: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConstants.normal,
                    horizontal: SizeConstants.normal,
                  ),
                  child: Row(
                    children: [
                      if (danceClass.teacher.imageUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: SizeConstants.big,
                            left: SizeConstants.mini,
                            top: SizeConstants.mini,
                            bottom: SizeConstants.mini,
                          ),
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(danceClass.teacher.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            danceClass.teacher.teacherName,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConstants.mini,
                            ),
                          ),
                          Text(
                            _getDanceClassTime(danceClass),
                            style: TextStyle(
                                fontSize: 14.0, color: Theme.of(context).textTheme.bodyText1?.color!.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            if (state is EditDanceClassStartSuccess)
              SliverToBoxAdapter(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConstants.large,
                  ),
                  child: Center(
                    child: MaterialButton(
                      height: 45,
                      elevation: 0,
                      highlightElevation: 0,
                      splashColor: Colors.transparent,
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<EditDanceClassBloc>(context).add(
                          EditDanceClassDeleted(
                            danceClass: danceClass,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: SizeConstants.big,
              ),
            ),

            // SliverToBoxAdapter(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     padding: EdgeInsets.symmetric(
            //       vertical: SizeConstants.large,
            //     ),
            //     child: Center(
            //       child: MaterialButton(
            //         height: 45,
            //         elevation: 0,
            //         highlightElevation: 0,
            //         splashColor: Colors.transparent,
            //         child: Text(
            //           'BUCHEN',
            //           style: TextStyle(
            //             fontSize: 16.0,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    });
  }

  String _getDanceClassTime(DanceClass danceClass) {
    return "${DateFormat.Hm().format(danceClass.time).toString()} - ${DateFormat.Hm().format(danceClass.time.add(Duration(minutes: danceClass.durationInMin))).toString()}";
  }
}
