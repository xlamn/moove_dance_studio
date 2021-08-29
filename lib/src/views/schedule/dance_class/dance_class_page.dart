import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class DanceClassPage extends StatelessWidget {
  final DanceClass danceClass;

  const DanceClassPage({
    Key? key,
    required this.danceClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
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
                      padding:
                          EdgeInsets.symmetric(vertical: SizeConstants.small),
                      child: Text(
                        danceClass.typeOfClass.toUpperCase(),
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: SizeConstants.small),
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
                            image: danceClass.teacherImage,
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
                          danceClass.teacherName,
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
                          danceClass.time,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color!
                                  .withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
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
  }
}
