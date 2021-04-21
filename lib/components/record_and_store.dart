// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_recorder/general/instances.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/general/instances.dart';

Record record = Record();

class Data {
  List<Record> listItem;

  Data({this.listItem});

  factory Data.fromJson(Map<String, dynamic> json) => json["record"]
      .map((dynamic key, dynamic value) =>
          Record.fromJson(value, DateTime.parse(key)))
      .toList();

  Map<String, dynamic> toJson() => <String, dynamic> {
    "record": List<dynamic>.from(listItem.map<Map<String, dynamic>>((i) => i.toJson())),
  };
}

class Record {
  Record({this.date, this.detail});

  DateTime date;
  RecordDetail detail;

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

  factory Record.fromJson(Map<String, dynamic> json, DateTime date) => Record(
        date: date,
        detail: RecordDetail.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        this.date.toLocal().toIso8601String(): detail.toJson(),
      };
}

class RecordDetail {
  double height;
  double weight;
  double bmi;

  RecordDetail({this.height, this.weight, this.bmi});

  factory RecordDetail.fromJson(Map<String, dynamic> json) => RecordDetail(
        height: json["height"],
        weight: json["weight"],
        bmi: json["bmi"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "Weight": weight,
        "BMI": bmi,
      };
}
