import 'dart:convert';
import 'package:flutter/services.dart';

Map<String, dynamic> lang;

Future<void> startupLanguageSelector() async {
  print("Loading Language File");
  String _json = await rootBundle.loadString("assets/lang/en.json");
  print("Language file:\n----------\n$_json\n----------");
  lang = jsonDecode(_json);
  print("Language Map is ready:\n----------\n$lang\n----------");
}
