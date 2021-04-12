import 'package:flutter/material.dart';
import 'package:health_recorder/screens/config.dart';
import 'package:health_recorder/theme/theme.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/screens/loading.dart';
import 'package:health_recorder/screens/email.dart';

void main() {
  runApp(AppHome());
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     startupLanguageSelector();
//     super.initState();
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: selectedTheme,
  //     home: Config(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startupLanguageSelector(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: lang["Title"],
            theme: selectedTheme,
            initialRoute: Config.id,
            routes: {
              Config.id: (context) => Config(),
              Email.id: (context) => Email(),
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
