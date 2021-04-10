import 'package:flutter/material.dart';
import 'package:health_recorder/theme/theme.dart';

void main() {
  runApp(AppHome());
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  void initState() {
    // TODO: Add Configuration Loader
    // TODO: Add Theme Selector
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: selectedTheme,
      initialRoute: ,
      routes: ,
    );
  }
}
