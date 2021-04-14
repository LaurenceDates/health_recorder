import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool signInState = false;

int checkSignInState() {
  FirebaseAuth.instance.currentUser != null
      ? signInState = true
      : signInState = false;
  return 0;
}

Future<int> register(String _email, String _password) async {
  UserCredential userCredential;
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: _email,
    password: _password,
  ).then((value) {
    userCredential = value;
  }).onError((error, stackTrace) {
    if (error is FirebaseAuthException) {
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return;
    }
    print('想定外エラーです');
  });
  try {
    signInState = true;
    return 0;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 1;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 2;
    }
  } catch (e) {
    print('想定外エラーです');
    return 2;
  }
}

Future<int> signIn(String _email, String _password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return 1;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return 2;
    } else {
      signInState = true;
      return 0;
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
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<int> signOut() async {
  await FirebaseAuth.instance.signOut();
  signInState = false;
  return 0;
}
