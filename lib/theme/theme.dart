import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:health_recorder/util/const.dart';

ThemeData selectedTheme = flutterDefaultDark;
/*
ThemeData selectedTheme = checkTheme(EnumToString.fromString(
    TYPE.values, SharedPreference.pref().instance.getString("theme")));
*/
final ThemeData flutterDefaultLight = ThemeData.light();
final ThemeData flutterDefaultDark = ThemeData.dark();

ThemeData checkTheme(TYPE type) {
  switch (type) {
    case TYPE.dark:
      // TODO: Handle this case.
      break;
    case TYPE.light:
      // TODO: Handle this case.
      break;
  }
}
