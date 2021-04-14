import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_recorder/bloc/theme_bloc.dart';
import 'package:health_recorder/screens/config.dart';
import 'package:health_recorder/screens/user_setting.dart';
import 'package:health_recorder/theme/theme.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/screens/email.dart';
import 'package:health_recorder/components/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkSignInState();
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
  final ThemeBloc bloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => bloc,
      dispose: (_, bloc) => bloc.dispose(),
      child: StreamBuilder(
        initialData: selectedTheme,
        stream: bloc.controller.stream,
        builder: (context, snapshot) {
          /*
          return FutureBuilder(
            future: startupLanguageSelector(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("");
              if (snapshot.hasData) {
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
              }
              return Container();
            },
          );

           */
          return MaterialApp(
            home: MultiProvider(
              providers: [
                Provider(
                    create: (context) => bloc,
                    dispose: (_, bloc) => bloc.dispose(),
                ),
                Provider(
                  create: (context) => bloc,
                  dispose: (_, bloc) => bloc.dispose(),
                ),
                Provider(
                  create: (context) => bloc,
                  dispose: (_, bloc) => bloc.dispose(),
                ),

              ],
              child: MaterialApp(
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: analytics),
                ],
                title: "aaa",
                theme: snapshot.data,
                routes: {
                  "/": (context) => UserSetting(),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
