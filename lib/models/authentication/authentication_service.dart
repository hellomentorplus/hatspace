import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';

enum SignUpType { googleService, facebookService }

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FacebookAuth _facebookAuth;
  AuthenticationService({
    GoogleSignIn? googleSignIn,
    FirebaseAuth? firebaseAuth,
    FacebookAuth? facebookAuth,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  Future<UserDetail> signUp({required SignUpType signUpType}) async {
    UserDetail userDetail;

    // CHECK authe service type
    switch (signUpType) {
      case SignUpType.googleService:
        userDetail = await signUpWithGoogle();
        break;
      case SignUpType.facebookService:
        userDetail = await signUpWithFacebook();
        break;
      default:
        throw UnimplementedError();
    }
    return userDetail;
  }

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

  Future<UserDetail> signUpWithFacebook() async {
    // Check Already Login
    try {
      User? user;
      final loginResult = await _facebookAuth.login();
      switch (loginResult.status) {
        case LoginStatus.success:
          user = await onFacebookLoginSuccess(loginResult);
          break;
        case LoginStatus.cancelled:
          // TODO: SHOW TOAST MESSAGE
          throw UserCancelException();
        default:
          throw (Exception);
      }
      return UserDetail(
          uid: user!.uid, email: user.email, phone: user.phoneNumber);
    } on UserCancelException catch (_) {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(stackTrace);
    }
  }

  Future<User?> onFacebookLoginSuccess(LoginResult loginResult) async {
    User? user;
    try {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final result = await _firebaseAuth.signInWithCredential(credential);
      user = result.user;
    } on Exception catch (_) {
      throw UserNotFoundException();
    }
    return user;
  }

  Future<UserDetail> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw UserNotFoundException();
    }

    return UserDetail(
        uid: firebaseUser.uid,
        phone: firebaseUser.phoneNumber,
        email: firebaseUser.email,
        displayName: firebaseUser.displayName);
  }

  Future<bool> getIsUserLoggedIn()async{
    return  _firebaseAuth.currentUser != null;
  }
}
