import 'package:flutter/material.dart';
import 'package:health_recorder/components/lang.dart';
import 'package:health_recorder/components/auth.dart';
import 'package:health_recorder/components/validator.dart';
import 'package:health_recorder/screens/config.dart';

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
                    setState(() {
                      _emailValid = emailValidator(_email);
                    });
                  },
                ),
                Row(children: _emailValidText()),
                TextField(
                  decoration: InputDecoration(
                    labelText: lang["Password"],
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
            child: Text(lang["SignIn"]),
          ),
        ],
      ),
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text(lang["EmailValid"])];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(lang["EmailInvalid"]),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text(lang["PasswordValid"])];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(lang["PasswordInvalid"]),
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
                  Text(lang["SignInFailed"]),
                ],
              ),
              content: Text(lang["NoUser"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(lang["Return"])),
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
                  Text(lang["SignInFailed"]),
                ],
              ),
              content: Text(lang["WrongPassword"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(lang["Return"])),
              ],
            );
          });
    } else {
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.sentiment_satisfied_alt),
            Text(lang["SignInSuccessful"]),
          ],
        ),
        content: Text(lang["SignInSuccessful"]),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Config.id);
              },
              child: Text(lang["Return"])),
        ],
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Icon(Icons.mail), Text(lang["EmailSignUp"])],
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
                    setState(() {
                      _emailValid = emailValidator(_email);
                    });
                  },
                ),
                Row(children: _emailValidText()),
                TextField(
                  decoration: InputDecoration(
                    labelText: lang["Password"],
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
                      labelText: lang["Password2"],
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
                Text(lang["PasswordExp1"]),
                Text(lang["PasswordExp2"]),
                Text(lang["PasswordExp3"]),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _emailValid && _passwordValid && _passwordMatch
                ? () {
                    _signUp(context, _email, _password);
                  }
                : null,
            child: Text(lang["SignUp"]),
          ),
        ],
      ),
    );
  }

  List<Widget> _emailValidText() {
    if (_emailValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text(lang["EmailValid"])];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(lang["EmailInvalid"]),
      ];
    }
  }

  List<Widget> _passwordValidText() {
    if (_passwordValid) {
      return [Icon(Icons.sentiment_satisfied_alt), Text(lang["PasswordValid"])];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(lang["PasswordInvalid"]),
      ];
    }
  }

  List<Widget> _passwordConfirmText() {
    if (_passwordMatch) {
      return [Icon(Icons.sentiment_satisfied_alt), Text(lang["PasswordValid"])];
    } else {
      return [
        Icon(Icons.sentiment_very_dissatisfied),
        Text(lang["PasswordInvalid"]),
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
                  Text(lang["SignUpFailed"]),
                ],
              ),
              content: Text(lang["PasswordWeak"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(lang["Return"])),
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
                  Text(lang["SignUpFailed"]),
                ],
              ),
              content: Text(lang["AccountExists"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(lang["Return"])),
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
                  Text(lang["SignUpSuccessful"]),
                ],
              ),
              content: Text(lang["SignUpSuccessful"]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Config.id);
                    },
                    child: Text(lang["Return"])),
              ],
            );
          });
    }
  }
}
