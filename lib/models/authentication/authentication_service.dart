import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hatspace/types/sign_up_message_type.dart';

const signUpSuccess = "SIGN_UP_SUCCESS";
const signUpFailed = "SIGN_UP_FAILED";

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<UserDetail> signUpWithGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } catch (e) {
      throw PlatformException(code: "sign_in_failed", message: "user canceled");
    }

    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth;
      OAuthCredential credential;
      googleAuth = await googleUser.authentication;
      credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await signUpFirebase(credential);
      return getCurrentUser();
    } else {
      throw PlatformException(
          code: "AUTH_CANCELED", message: "Authentication canceled by user");
    }
  }

  Future<void> signUpFirebase(OAuthCredential credential) async {
    try {
      UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      // if (user.additionalUserInfo?.isNewUser == false) {
      //   throw PlatformException(
      //       code: "AUTH_CANCELED", message: "Account already create");
      // }
    } on FirebaseAuthException catch (e) {
      throw {e.code, e.message};
    }
  }

  Future<UserDetail> getCurrentUser() async {
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

class SignUpStatusMessage {
  static const alreadyHaveAccount = SignUpMessageType.AlreadyHaveAccount ;
  static const authenticationFaildMessage = SignUpMessageType.SignUpFalse;
}
