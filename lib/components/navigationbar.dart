import 'package:flutter/material.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/screens/input.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Input.id);
          },
          child: Text(
            lang["NAVInput"],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            lang["NAVRecord"],
          ),
        ),
      ],
    );
  }
}
