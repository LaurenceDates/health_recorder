import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/screens/email.dart';
import 'package:health_recorder/components/auth.dart';

class Config extends StatefulWidget {
  static final id = "Config";
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  bool signInState;

  @override
  void initState() {
    super.initState();
    // .listenを使うなら、このように画面作成時に呼び出さないと間に合わない可能性が出てくる
    signInState = FirebaseAuth.instance.currentUser.uid != null;
    FirebaseAuth.instance.authStateChanges().listen(
          (User user) {
        if (user == null) {
          signInState = false;

          print("User is NOT signed in!");
        } else {
          signInState = true;
          print("User is signed in.");
        }
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings),
            Text(lang["Config"]),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, EmailSignIn.id);
            },
            child: Text(
              lang["NAVInput"],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              lang["NAVRecord"],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.language),
                    Text(lang["LangConfig"]),
                  ],
                ),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English (Default)"),
                    ),
                  ],
                ),
                Text("Language Text is under construction. It's coming soon.")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_fix_normal),
                    Text(lang["Theme"]),
                  ],
                ),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text("Flutter Default Light Theme"),
                    ),
                    DropdownMenuItem(
                      child: Text("Flutter Default Dark Theme"),
                    ),
                  ],
                ),
                Text(
                    "Custom Theme is still under construction. It's coming soon.")
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle),
                    Text(lang["Account"]),
                  ],
                ),
                _signInState(),
                Column(
                  children: _signInBlock(),
                ),
                Text(lang["AccountExp"])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInState() {
    if (signInState) {
      return Text(lang["SignedIn"]);
    } else
      return Text(lang["NotSignedIn"]);
  }

  List<Widget> _signInBlock() {
    if (signInState == true) {
      return [
        ElevatedButton(
          onPressed: () {
            setState(() {
              signOut();
            });
          },
          child: Row(
            children: [Icon(Icons.outbond), Text(lang["SignOut"])],
          ),
        ),
      ];
    } else {
      return [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, EmailSignUp.id);
          },
          child: Row(
            children: [
              Icon(Icons.mail_outline),
              Text(lang["EmailSignUp"]),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, EmailSignIn.id);
          },
          child: Row(
            children: [
              Icon(Icons.mail),
              Text(lang["EmailSignIn"]),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await signInWithGoogle();
          },
          child: Row(
            children: [
              Image.asset(
                "assets/img/google.png",
                width: 20,
                height: 20,
              ),
              Text(lang["GoogleSignIn"])
            ],
          ),
        ),
      ];
    }
  }
}
