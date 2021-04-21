import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderPreferences extends ChangeNotifier {
  Map<String, dynamic> languageMap;

  ThemeData selectedTheme = ThemeData.light();
  bool unit = false;
  bool firstLaunch = true;

  Map<String, dynamic> record;

  SharedPreferences prefs;

  void loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setFirstLaunch(prefs.getBool("FirstLaunch") ?? true);
    changeLanguage(prefs.getString("Language") ?? "en");
    changeTheme(prefs.getString("Theme") ?? "defaultLightTheme");
    switchUnit(prefs.getBool("Unit") ?? false);
  }

  void setFirstLaunch(bool value) {
    firstLaunch = value;
  }

//TODO: Rewrite to use Enum, move functions to lang.dart
//TODO: Set loadingState
  void changeLanguage(String languageName) async {
    String _json = await rootBundle.loadString("assets/lang/en.json");
    languageMap = jsonDecode(_json);
    switch (languageName) {
      case "en":
        break;
      case "ja":
        String _json = await rootBundle.loadString("assets/lang/ja.json");
        languageMap.addAll(jsonDecode(_json));
        break;
    }
    notifyListeners();
  }

  void changeTheme(String themeName) {
    // TODO: Rewrite to use Enum, move to theme.dart
    switch (themeName) {
      case "defaultLightTheme":
        selectedTheme = ThemeData.light();
        break;
      case "defaultDarkTheme":
        selectedTheme = ThemeData.dark();
        break;
      default:
        selectedTheme = ThemeData.light();
    }
    notifyListeners();
  }

  void switchUnit(bool value) {
    unit = value;
    prefs.setBool("Unit", value);
    notifyListeners();
  }
}
