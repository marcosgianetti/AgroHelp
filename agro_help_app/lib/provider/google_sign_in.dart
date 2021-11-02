import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _userGoogle;

  GoogleSignInAccount get user => _userGoogle!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;
    _userGoogle = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future googleLogout() async {
    try {
      await googleSignIn.disconnect().whenComplete(() async {
        await FirebaseAuth.instance.signOut();
      });
    } catch (e) {
      print('Logout error: ' + e.toString());
    }
  }
}
