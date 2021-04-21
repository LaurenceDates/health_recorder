import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/screens/navigationbar.dart';
import 'package:health_recorder/screens/screen_email.dart';
import 'package:health_recorder/components/auth.dart';
import 'package:health_recorder/general/instances.dart';
import 'package:health_recorder/providers/provider_preferences.dart';
import 'package:health_recorder/providers/provider_signin.dart';

class Config extends StatelessWidget {
  static final id = "Config";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings),
            Text(Provider.of<ProviderPreferences>(context)
                .languageMap["Config"]),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.language),
                    Text(Provider.of<ProviderPreferences>(context)
                        .languageMap["LangConfig"]),
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
                    Text(Provider.of<ProviderPreferences>(context)
                        .languageMap["Theme"]),
                  ],
                ),
                DropdownButton(
                  items: <DropdownMenuItem>[
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
                    Text(Provider.of<ProviderPreferences>(context)
                        .languageMap["Account"]),
                  ],
                ),
                signInState(context),
                Column(
                  children: signInBlock(context),
                ),
                Text(Provider.of<ProviderPreferences>(context)
                    .languageMap["AccountExp"])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget signInState(BuildContext context) {
    if (Provider.of<ProviderSignIn>(context).user != null) {
      return Text(
          Provider.of<ProviderPreferences>(context).languageMap["SignedIn"]);
    } else
      return Text(
          Provider.of<ProviderPreferences>(context).languageMap["NotSignedIn"]);
  }

  List<Widget> signInBlock(BuildContext context) {
    if (Provider.of<ProviderSignIn>(context).user != null) {
      return [
        ElevatedButton(
          onPressed: () async {
            await signOut();
            Provider.of<ProviderSignIn>(context, listen: false)
                .updateSignInState();
          },
          child: Row(
            children: [
              Icon(Icons.outbond),
              Text(Provider.of<ProviderPreferences>(context)
                  .languageMap["SignOut"])
            ],
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
              Text(Provider.of<ProviderPreferences>(context)
                  .languageMap["EmailSignUp"]),
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
              Text(Provider.of<ProviderPreferences>(context)
                  .languageMap["EmailSignIn"]),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await signInWithGoogle();
            Provider.of<ProviderSignIn>(context, listen: false)
                .updateSignInState();
          },
          child: Row(
            children: [
              Image.asset(
                "assets/img/google.png",
                width: 20,
                height: 20,
              ),
              Text(Provider.of<ProviderPreferences>(context)
                  .languageMap["GoogleSignIn"])
            ],
          ),
        ),
      ];
    }
  }
}

// class Config extends StatefulWidget {
//   static final id = "Config";
//   @override
//   _ConfigState createState() => _ConfigState();
// }
//
// class _ConfigState extends State<Config> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.settings),
//             Text(Provider.of<ProviderPreferences>(context)
//                 .languageMap["Config"]),
//           ],
//         ),
//       ),
//       bottomNavigationBar: NavigationBar(),
//       body: Column(
//         children: [
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.language),
//                     Text(Provider.of<ProviderPreferences>(context)
//                         .languageMap["LangConfig"]),
//                   ],
//                 ),
//                 DropdownButton(
//                   items: [
//                     DropdownMenuItem(
//                       value: "en",
//                       child: Text("English (Default)"),
//                     ),
//                   ],
//                 ),
//                 Text("Language Text is under construction. It's coming soon.")
//               ],
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.auto_fix_normal),
//                     Text(Provider.of<ProviderPreferences>(context)
//                         .languageMap["Theme"]),
//                   ],
//                 ),
//                 DropdownButton(
//                   items: <DropdownMenuItem>[
//                     DropdownMenuItem(
//                       child: Text("Flutter Default Light Theme"),
//                     ),
//                     DropdownMenuItem(
//                       child: Text("Flutter Default Dark Theme"),
//                     ),
//                   ],
//                 ),
//                 Text(
//                     "Custom Theme is still under construction. It's coming soon.")
//               ],
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.account_circle),
//                     Text(Provider.of<ProviderPreferences>(context)
//                         .languageMap["Account"]),
//                   ],
//                 ),
//                 _signInState(),
//                 Column(
//                   children: _signInBlock(),
//                 ),
//                 Text(Provider.of<ProviderPreferences>(context)
//                     .languageMap["AccountExp"])
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _signInState() {
//     if (Provider.of<ProviderSignIn>(context).userID != null) {
//       return Text(
//           Provider.of<ProviderPreferences>(context).languageMap["SignedIn"]);
//     } else
//       return Text(
//           Provider.of<ProviderPreferences>(context).languageMap["NotSignedIn"]);
//   }
//
//   List<Widget> _signInBlock() {
//     if (Provider.of<ProviderSignIn>(context).userID != null) {
//       return [
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               signOut();
//             });
//           },
//           child: Row(
//             children: [
//               Icon(Icons.outbond),
//               Text(Provider.of<ProviderPreferences>(context)
//                   .languageMap["SignOut"])
//             ],
//           ),
//         ),
//       ];
//     } else {
//       return [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, EmailSignUp.id);
//           },
//           child: Row(
//             children: [
//               Icon(Icons.mail_outline),
//               Text(Provider.of<ProviderPreferences>(context)
//                   .languageMap["EmailSignUp"]),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, EmailSignIn.id);
//           },
//           child: Row(
//             children: [
//               Icon(Icons.mail),
//               Text(Provider.of<ProviderPreferences>(context)
//                   .languageMap["EmailSignIn"]),
//             ],
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             await signInWithGoogle();
//             Provider.of<ProviderSignIn>(context).updateSignInState();
//           },
//           child: Row(
//             children: [
//               Image.asset(
//                 "assets/img/google.png",
//                 width: 20,
//                 height: 20,
//               ),
//               Text(Provider.of<ProviderPreferences>(context)
//                   .languageMap["GoogleSignIn"])
//             ],
//           ),
//         ),
//       ];
//     }
//   }
// }
