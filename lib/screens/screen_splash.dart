import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/screens/screen_config.dart';

class Splash extends StatelessWidget {
  static final String id = "Splash";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Provider.of<ProviderPreferences>(context, listen: false)
                .loadPreferences();
            Provider.of<ProviderSignIn>(context, listen: false)
                .updateSignInState();
            Navigator.pushNamed(context, Config.id);
          },
          child: Text("Tap to Run App")),
    );
  }
}
