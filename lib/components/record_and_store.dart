// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_recorder/general/instances.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/general/instances.dart';

Record record = Record();

class Record {
  Map<DateTime, dynamic> record;

  // void loadRecordfromDevice() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String savedStringRecord = pref.getString("record");
  //   Map<DateTime, dynamic> savedRecord = jsonDecode(savedStringRecord);
  //   record.addAll(savedRecord);
  // }

  Future<void> readRecordfromStore(BuildContext context) async {
    print(userID);
    DocumentSnapshot doc = await firestoreRecord.doc(userID).get();
    print(doc.data());
  }

  void newInput({Timestamp date, double height, double weight}) {
    double bmiTmp = weight / (height / 100) / (height / 100) * 100;
    double bmi = bmiTmp.round() / 100;
    Map<String, dynamic> newData = {
      "date": date,
      "height": height,
      "Weight": weight,
      "BMI": bmi,
    };

    firestoreRecord
        .doc(userID)
        .set(
          {
            "record": {
              "2": {
                "date": date,
                "height": height,
                "weight": weight,
                "bmi": bmi,
              }
            }
          },
          SetOptions(merge: true),
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
