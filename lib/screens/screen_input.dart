import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_recorder/components/flutter_icons_icons.dart';
import 'package:health_recorder/general/instances.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/providers/provider_signin.dart';
import 'package:health_recorder/components/record_and_store.dart';

class Input extends StatefulWidget {
  static final id = "Input";
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  DateTime inputDate = DateTime.now();
  Timestamp inputTimeStamp;
  double inputHeight;
  double inputWeight;
  double calculatedBMI;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(FlutterIcons.weight_hanging),
              Text(Provider.of<ProviderPreferences>(context)
                  .languageMap["Input"])
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                children: _singStateText(),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text(Provider.of<ProviderPreferences>(context)
                        .languageMap["AddRecord"]),
                  ),
                  Row(
                    children: [
                      Text("Date: "),
                      Text(
                          "${inputDate.year}-${inputDate.month}-${inputDate.day}"),
                      IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime dateChosen = await showDatePicker(
                              context: context,
                              initialDate: inputDate,
                              firstDate: DateTime(inputDate.year - 50),
                              lastDate: DateTime(inputDate.year + 1),
                            );
                            setState(() {
                              inputDate = dateChosen;
                            });
                            inputTimeStamp = Timestamp.fromDate(inputDate);
                          })
                    ],
                  ),
                  Row(
                    children: [
                      Text("Height: "),
                      Container(
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[0-9.]"),
                                allow: true)
                          ],
                          onChanged: (String value) {
                            setState(() {
                              inputHeight = double.parse(value);
                              calculateBMI();
                            });
                          },
                        ),
                      ),
                      Text("CM")
                    ],
                  ),
                  Row(
                    children: [
                      Text("Weight: "),
                      Container(
                        width: 80,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[0-9.]"),
                                allow: true)
                          ],
                          onChanged: (String value) {
                            setState(() {
                              inputWeight = double.parse(value);
                              calculateBMI();
                            });
                          },
                        ),
                      ),
                      Text("KG")
                    ],
                  ),
                  Row(
                    children: [
                      Text("BMI: "),
                      Text(calculatedBMI.toString()),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        userRecord.newInput(
                          date: inputTimeStamp,
                          height: inputHeight,
                          weight: inputWeight,
                        );
                      },
                      child: Text("sendRecord")),
                  ElevatedButton(
                      onPressed: () {
                        record.readRecordfromStore(context);
                      },
                      child: Text("getRecord")),
                  ElevatedButton(
                      onPressed: () {
                        print(DateTime.now());
                      },
                      child: Text("Now!"))
                ],
              ),
            )
          ],
        ));
  }

  List<Widget> _singStateText() {
    if (Provider.of<ProviderSignIn>(context).user != null) {
      return [
        Text(Provider.of<ProviderPreferences>(context).languageMap["SignedIn"]),
        Text(Provider.of<ProviderPreferences>(context)
            .languageMap["CloudRecord"]),
      ];
    } else {
      return [
        Text(Provider.of<ProviderPreferences>(context)
            .languageMap["NotSignedIn"]),
        Text(Provider.of<ProviderPreferences>(context)
            .languageMap["LocalRecord"]),
      ];
    }
  }

  void calculateBMI() {
    if (inputWeight != null && inputWeight != null) {
      double BMItmp1 = inputWeight / inputHeight / inputHeight * 1000000;
      int BMItmp2 = BMItmp1.round();
      calculatedBMI = BMItmp2 / 100;
    } else {
      calculatedBMI = null;
    }
  }
}
