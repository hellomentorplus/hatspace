import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/data.dart';
import 'authentication_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<UserDetail> signUpWithGoogle({AuthCredential? authCredential}) async {
    // no login yet, sign in with google now
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        throw UserCancelException();
      }
      GoogleSignInAuthentication gsa = await account.authentication;

      AuthCredential credential = authCredential ??
          GoogleAuthProvider.credential(
            accessToken: gsa.accessToken,
            idToken: gsa.idToken,
          );

      final result = await _firebaseAuth.signInWithCredential(credential);

      final User? user = result.user;
      if (user == null) {
        throw UserNotFoundException();
      }

      return UserDetail(
          uid: user.uid, email: user.email, phone: user.phoneNumber);
    } on PlatformException catch (e) {
      throw AuthenticationException(e.code, e.message);
    } on UserNotFoundException catch (_) {
      rethrow;
    } on UserCancelException catch (_) {
      rethrow;
    } catch (e, stacktrace) {
      throw UnknownException(stacktrace);
    }
  }

  Future<UserDetail> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw UserNotFoundException();
    }
    return UserDetail(
        uid: firebaseUser.uid,
        phone: firebaseUser.phoneNumber,
        email: firebaseUser.email);
  }
}
