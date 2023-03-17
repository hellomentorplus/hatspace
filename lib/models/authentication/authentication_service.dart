import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../data/data.dart';
import 'authentication_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FacebookAuth _facebookAuth;
  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth, FacebookAuth? facebookAuth,})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;
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

    Future<void> signUpFirebase(OAuthCredential credential) async {
    try {
      UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      //Check old user with userCredential.additionalUSer.isNewUser
    } on FirebaseAuthException catch (e) {
      throw {e.code, e.message};
    }
  }

   Future<UserDetail?> signUpWithFacebook() async {
    // Check Already Login
    final accessToken = await _facebookAuth.accessToken;
    if (accessToken != null) {
      // Check already login with facebook
      // UserDetail user =await getUserDetail();
      // return user;
      // TODO: Check choose role logic
      await _facebookAuth.logOut(); // Need to remove after merge
    } else {
      try {
        final loginResult = await _facebookAuth.login();
        if (loginResult.status == LoginStatus.success) {
          final OAuthCredential credential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);
          signUpFirebase(credential);
          UserDetail user = await getCurrentUser();
          return user;
        } else {
          // TODO: Show toast error toast message
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

}
