// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_recorder/general/instances.dart';

class ProviderSignIn extends ChangeNotifier {
  User user;

  void updateSignInState() {
    user = auth.currentUser;
    userID = user.uid;
    print("user: $user");
    print("userID: $userID");
    notifyListeners();
  }
}

// class ProviderSignIn {
//   User userID;
//
//   StreamController<User> _userIDController = StreamController();
//   Stream<User> get userIDStream => _userIDController.stream;
//
//   void updateSignInState() {
//     this._userIDController.sink.add(FirebaseAuth.instance.currentUser);
//   }
//
//   void dispose() {
//     this._userIDController.close();
//   }
// }
