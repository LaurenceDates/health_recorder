import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_recorder/screens/screen_splash.dart';
import 'package:provider/provider.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
//providers
import 'package:health_recorder/providers/provider_connectivity.dart';
import 'package:health_recorder/providers/provider_loading.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
// Routes
import 'package:health_recorder/screens/screen_input.dart';
import 'package:health_recorder/screens/screen_config.dart';
import 'package:health_recorder/screens/screen_email.dart';
//Others
import 'package:health_recorder/general/instances.dart';
import 'package:health_recorder/screens/screen_loading_overwrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GeneralProviders());
}

class GeneralProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderPreferences>(
            create: (context) => ProviderPreferences()),
        ChangeNotifierProvider<ProviderSignIn>(
            create: (context) => ProviderSignIn()),
      ],
      child: AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {
  bool flag = false;

  void changeFlag(bool value) {
    setState(() {
      flag = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Title",
        theme: Provider.of<ProviderPreferences>(context).selectedTheme,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        initialRoute: Splash.id,
        routes: {
          Splash.id: (context) => Splash(callBack: changeFlag,),
          Config.id: (context) => Config(),
          EmailSignIn.id: (context) => EmailSignIn(),
          EmailSignUp.id: (context) => EmailSignUp(),
          Input.id: (context) => Input(),
        });
  }
}
