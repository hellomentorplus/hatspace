import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FacebookAuth _facebookAuth;
  late FacebookAuthProvider _authProvider;
  AuthenticationService(
      {FacebookAuth? facebookAuth,
      FirebaseAuth? firebaseAuth,
      FacebookAuthProvider? authProvider})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;
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
          UserDetail user = await getUserDetail();
          return user;
        } else {
          // TODO: Show toast error toast message
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
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

  Future<UserDetail> getUserDetail() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
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
