import 'dart:convert';
import 'package:flutter/services.dart';

Map<String, dynamic> lang;

Future<void> startupLanguageSelector() async {
  String _json = await rootBundle.loadString("lang/en.json");
  print("Language file:\n----------\n$_json\n----------");
  lang = await jsonDecode(_json);
  print("Language Map is ready:\n----------\n$lang\n----------");
}
