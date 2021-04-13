import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool signInState = false;

// .listenの部分が非同期なので、ここのReturnは機能していない。
// また、.listenは「通知を受け取る」処理になるので、ボタンを押下したときに用意するのではタイミングが遅い
/*
int checkSignInState() {
  FirebaseAuth.instance.currentUser != null
      ? signInState = true
      : signInState = false;
  return 0;
}
*/
Future<int> register(String _email, String _password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return 1;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return 2;
    }
  } catch (e) {
    print(e);
    signInState = true;
    return 0;
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
