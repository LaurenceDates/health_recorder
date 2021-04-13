import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_recorder/screens/config.dart';
import 'package:health_recorder/theme/theme.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/screens/email.dart';
import 'package:health_recorder/components/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: startupLanguageSelector(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            title: lang["Title"],
            theme: selectedTheme,
            initialRoute: Config.id,
            routes: {
              Config.id: (context) => Config(),
              EmailSignIn.id: (context) => EmailSignIn(),
              EmailSignUp.id: (context) => EmailSignUp(),
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
