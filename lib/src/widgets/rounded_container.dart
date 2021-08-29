import 'package:flutter/material.dart';
import 'package:moove_dance_studio/moove_dance_studio.dart';

class RoundedContainer extends StatelessWidget {
  final List<Widget> items;

  RoundedContainer({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConstants.small,
      ),
      child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConstants.normal,
            vertical: SizeConstants.mini,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.25,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            children: items,
          )),
    );
  }
}
