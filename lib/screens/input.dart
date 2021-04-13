import 'package:flutter/material.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/components/flutter_icons_icons.dart';

class Input extends StatefulWidget {
  static final id = "Input";
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Icon(FlutterIcons.weight_hanging), Text(lang["Input"])],
        ),
      ),
    );
  }
}
