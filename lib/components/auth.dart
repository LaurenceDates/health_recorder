import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:health_recorder/general/instances.dart';

//TODO: Edit this file

Future<int> register(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 0;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('Error Code: ${e.code} \n The password provided is too weak.');
      return 1;
    } else if (e.code == 'email-already-in-use') {
      print(
          'Error Code: ${e.code} \n The account already exists for that email.');
      return 2;
    }
  } catch (e) {
    print("Error: $e");
    return 3;
  }
}

Future<int> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 0;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return 1;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return 2;
    } else {
      print("Error: $e");
      return 3;
    }
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await auth.signInWithCredential(credential);
}

Future<int> signOut() async {
  await auth.signOut();
  return 0;
}
