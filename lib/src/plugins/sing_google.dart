import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<FirebaseUser> singGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return (await _auth.signInWithCredential(credential)).user;
  }on PlatformException catch (_) {
    return null;
  }
}

void singOut() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut();
}

Future<String> singIn(String email,String password) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
      return (await _auth.createUserWithEmailAndPassword(
      email    : email,
      password : password,
    )).user.uid;
  } catch (e) {
    return handleError(e);
  }


}
Future<String> logIn(String email,String password) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
   final auth = await _auth.signInWithEmailAndPassword(email:email,password:password);
   return auth.user.uid;
  } catch (e) {
    return handleError(e);
  }

}

String handleError(PlatformException error) {
   return error.code;
  
  }
