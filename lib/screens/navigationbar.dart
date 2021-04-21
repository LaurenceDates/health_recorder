import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/screens/screen_input.dart';

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
            Provider.of<ProviderPreferences>(context).languageMap["NAVInput"],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            Provider.of<ProviderPreferences>(context).languageMap["NAVRecord"],
          ),
        ),
      ],
    );
  }
}
