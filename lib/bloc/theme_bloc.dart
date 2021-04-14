import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_recorder/theme/theme.dart';
import 'package:health_recorder/util/const.dart';


class ThemeBloc {
  final StreamController<ThemeData> controller = StreamController<ThemeData>.broadcast();

  void changeTheme(TYPE type) {

    switch(type) {
      case TYPE.dark:
        controller.sink.add(flutterDefaultDark);
        break;
      case TYPE.light:
        controller.sink.add(flutterDefaultLight);
        break;
    }
  }

  void dispose() {
    controller.close();
  }
}