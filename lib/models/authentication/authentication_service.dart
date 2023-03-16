import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<void> signUpWithGoogle() async {
    // no login yet, sign in with google now
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        throw UserCancelException();
      }
      GoogleSignInAuthentication gsa = await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: gsa.accessToken,
            idToken: gsa.idToken,
          );

      final result = await _firebaseAuth.signInWithCredential(credential);

      final User? user = result.user;
      if (user == null) {
        throw UserNotFoundException();
      }
    } on PlatformException catch (_) {
      rethrow;
    } catch (e, _) {
      rethrow;
    }
  }

  Future<UserDetail> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      print('SUESI: error user not found');
      throw FirebaseAuthException(
          code: "USER_NOT_FOUND", message: "User not found");
    }
    return UserDetail(
        uid: firebaseUser.uid,
        phone: firebaseUser.phoneNumber,
        email: firebaseUser.email);
  }
}

class UserDetail {
  final String? uid;
  final String? phone;
  final String? email;

  UserDetail({required this.uid, this.phone, this.email});
}
