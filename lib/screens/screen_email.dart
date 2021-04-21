import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/components/auth.dart';
import 'package:health_recorder/components/validator.dart';
import 'package:health_recorder/screens/screen_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

// EmailSignIn
class EmailSignIn extends StatefulWidget {
  static final id = "EmailSignIn";
  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  String _email;
  String _password;
  bool _emailValid = false;
  bool _passwordValid = false;

  AsyncSnapshot<ThemeData> snapshotTheme;
  AsyncSnapshot<Map<String, dynamic>> snapshotLanguage;
  AsyncSnapshot<bool> snapshotConnectivity;
  AsyncSnapshot<User> snapshotUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.mail),
            Text(Provider.of<ProviderPreferences>(context).languageMap["EmailSignIn"])
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: Provider.of<ProviderPreferences>(context).languageMap["Email"],
                  ),
                  onChanged: (String _value) {
                    _email = _value;
                    setState(() {
                      _emailValid = emailValidator(_email);
                    });
                  },
                ),
                Row(children: _emailValidText()),
                TextField(
                  decoration: InputDecoration(
                    labelText: Provider.of<ProviderPreferences>(context).languageMap["Password"],
                  ),
                  onChanged: (String _value) {
                    _password = _value;
                    setState(() {
                      _passwordValid = passwordValidator(_password);
                    });
                  },
                ),
                Row(children: _passwordValidText()),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _emailValid && _passwordValid
                ? () {
                    _signIn(context, _email, _password);
                  }
                : null,
            child: Text(Provider.of<ProviderPreferences>(context).languageMap["SignIn"]),
          ),
        ],
      ),
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [
        Icon(Icons.sentiment_satisfied_alt),
        Text(
            Provider.of<ProviderPreferences>(context).languageMap["EmailValid"])
      ];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(Provider.of<ProviderPreferences>(context).languageMap["EmailInvalid"]),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [
        Icon(Icons.sentiment_satisfied_alt),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordValid"])
      ];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordInvalid"]),
      ];
    }
  }

  _signIn(context, _email, _password) async {
    int _state = await signIn(_email, _password);
    if (_state == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_very_dissatisfied),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignInFailed"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["NoUser"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    } else if (_state == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_very_dissatisfied),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignInFailed"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["WrongPassword"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignInSuccessful"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["SignInSuccessful"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Config.id);
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    }
  }
}

// EmailSignUp
class EmailSignUp extends StatefulWidget {
  static final id = "EmailSignUp";
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  String _email;
  String _password;
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _passwordMatch = false;

  AsyncSnapshot<ThemeData> snapshotTheme;
  AsyncSnapshot<Map<String, dynamic>> snapshotLanguage;
  AsyncSnapshot<bool> snapshotConnectivity;
  AsyncSnapshot<User> snapshotUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.mail),
            Text(Provider.of<ProviderPreferences>(context).languageMap["EmailSignUp"])
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: Provider.of<ProviderPreferences>(context).languageMap["Email"],
                  ),
                  onChanged: (String _value) {
                    _email = _value;
                    setState(() {
                      _emailValid = emailValidator(_email);
                    });
                  },
                ),
                Row(children: _emailValidText()),
                TextField(
                  decoration: InputDecoration(
                    labelText: Provider.of<ProviderPreferences>(context).languageMap["Password"],
                  ),
                  onChanged: (String _value) {
                    _password = _value;
                    setState(() {
                      _passwordValid = passwordValidator(_password);
                    });
                  },
                ),
                Row(children: _passwordValidText()),
                TextField(
                    decoration: InputDecoration(
                      labelText: Provider.of<ProviderPreferences>(context).languageMap["Password2"],
                    ),
                    onChanged: (_value) {
                      setState(() {
                        if (_value == _password) {
                          _passwordMatch = true;
                        } else {
                          _passwordMatch = false;
                        }
                      });
                    }),
                Row(children: _passwordConfirmText()),
                Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordExp1"]),
                Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordExp2"]),
                Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordExp3"]),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _emailValid && _passwordValid && _passwordMatch
                ? () {
                    _signUp(context, _email, _password);
                  }
                : null,
            child: Text(Provider.of<ProviderPreferences>(context).languageMap["SignUp"]),
          ),
        ],
      ),
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [
        Icon(Icons.sentiment_satisfied_alt),
        Text(
            Provider.of<ProviderPreferences>(context).languageMap["EmailValid"])
      ];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(Provider.of<ProviderPreferences>(context).languageMap["EmailInvalid"]),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [
        Icon(Icons.sentiment_satisfied_alt),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordValid"])
      ];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordInvalid"]),
      ];
    }
  }

  List<Widget> _passwordConfirmText() {
    if (_passwordMatch) {
      return [
        Icon(Icons.sentiment_satisfied_alt),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordValid"])
      ];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordInvalid"]),
      ];
    }
  }

  _signUp(context, _email, _password) async {
    int _state = await register(_email, _password);
    if (_state == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_very_dissatisfied),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignUpFailed"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["PasswordWeak"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Config.id, ModalRoute.withName("/"));
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    } else if (_state == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_very_dissatisfied),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignUpFailed"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["AccountExists"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt),
                  Text(Provider.of<ProviderPreferences>(context).languageMap["SignUpSuccessful"]),
                ],
              ),
              content: Text(Provider.of<ProviderPreferences>(context).languageMap["SignUpSuccessful"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Config.id, ModalRoute.withName("/"));
                      ;
                    },
                    child: Text(Provider.of<ProviderPreferences>(context).languageMap["Return"])),
              ],
            );
          });
    }
  }
}
