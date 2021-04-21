import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/screens/screen_config.dart';

class Splash extends StatelessWidget {
  static final String id = "Splash";
  final Function callBack;

  const Splash({Key key, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            callBack(true);
          },
          child: Text("Tap to Run App")),
    );
  }
}
