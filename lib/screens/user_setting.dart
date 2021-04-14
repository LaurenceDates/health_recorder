import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_recorder/bloc/theme_bloc.dart';
import 'package:health_recorder/util/const.dart';
import 'package:provider/provider.dart';

class UserSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeBloc bloc = Provider.of<ThemeBloc>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: MaterialButton(
                    child: Text("change LIGHT"),
                    onPressed: () {
                      bloc.changeTheme(TYPE.light);
                    },
                  ),
                ),
                Center(
                  child: MaterialButton(
                    child: Text("change DARK"),
                    onPressed: () {
                      bloc.changeTheme(TYPE.dark);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}