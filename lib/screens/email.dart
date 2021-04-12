import 'package:flutter/material.dart';
import 'package:health_recorder/components/lang.dart';

class Email extends StatelessWidget {
  static final id = "Email";
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Icon(Icons.mail), Text(lang["EmailSignIn"])],
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: lang["Email"],
                  ),
                  onChanged: (String _value) {
                    _email = _value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: lang["Password"],
                  ),
                  onChanged: (String _value) {
                    _password = _value;
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(lang["SignIn"]),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(lang["SignUp"]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
