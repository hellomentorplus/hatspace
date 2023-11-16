import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum SignUpType { googleService, facebookService, appleService }

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;
  final FacebookAuth _facebookAuth;
  StreamSubscription? _streamSubscription;
  bool isAppleSignInAvailable;

  AuthenticationService({
    GoogleSignIn? googleSignIn,
    FirebaseAuth? firebaseAuth,
    FacebookAuth? facebookAuth,
    this.isAppleSignInAvailable = false,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  void initialiseUserDetailStream() {
    _streamSubscription = _firebaseAuth.authStateChanges().listen((event) {
      if (event != null) {
        UserDetail userDetail = UserDetail(
            displayName: event.displayName,
            uid: event.uid,
            email: event.email,
            phone: event.phoneNumber);
        _userDetailStreamController.add(userDetail);
      } else {
        _userDetailStreamController.add(null);
      }
    });
    checkAppleSignInAvailable().then((result) {
      isAppleSignInAvailable = result;
    });
  }

  void closeUserDetailStream() {
    _streamSubscription?.cancel();
  }

  final StreamController<UserDetail?> _userDetailStreamController =
      StreamController.broadcast();

  Stream<UserDetail?> get authenticationState =>
      _userDetailStreamController.stream;

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
      case SignUpType.appleService:
        userDetail = await signInWithAppleId();
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
          uid: user.uid,
          email: user.email,
          phone: user.phoneNumber,
          displayName: user.displayName);
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
          uid: user!.uid,
          email: user.email,
          phone: user.phoneNumber,
          displayName: user.displayName);
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

  Future<UserDetail> signInWithAppleId() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);
      User? user = userCredential.user;
      if (user != null) {
        //Check when email null
        if (user.email == null) {
          await user.updateEmail(credential.email!);
        }
        // TODO: Handle when user hide email
        // Check display name null
        if (user.displayName == null) {
          await user.updateDisplayName(
              '${credential.givenName} ${credential.familyName}');
        }
      }
      //update email and display name
      final String? email = credential.email ?? user?.email;
      //TODO: Validate when user hide user display name
      final String? displayName;
      if (credential.givenName == null || credential.familyName == null) {
        displayName = user?.displayName;
      } else {
        displayName = '${credential.givenName} ${credential.familyName}';
      }
      if (user == null || email == null || email.isEmpty == true) {
        throw UserNotFoundException();
      }

      final UserDetail result = UserDetail(
        uid: user.uid,
        email: email,
        displayName: displayName,
        avatar: user.photoURL,
      );
      // Need to add new User with display name to stream to update state
      _userDetailStreamController.add(result);
      return result;
    } catch (e, stacktrace) {
      throw UnknownException(stacktrace);
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
        displayName: firebaseUser.displayName,
        avatar: firebaseUser.photoURL);
  }

  Future<void> updateUserDisplayName(String displayName) async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw UserNotFoundException();
    }

    await firebaseUser.updateDisplayName(displayName);

    _userDetailStreamController.add(UserDetail(
        uid: firebaseUser.uid,
        phone: firebaseUser.phoneNumber,
        email: firebaseUser.email,
        displayName: displayName,
        avatar: firebaseUser.photoURL));
  }

  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _facebookAuth.logOut(),
      _firebaseAuth.signOut()
    ]);
  }

  bool get isUserLoggedIn => _firebaseAuth.currentUser != null;

  Future<bool> checkAppleSignInAvailable() async {
    try {
      return SignInWithApple.isAvailable();
    } catch (e) {
      return false;
    }
  }
}
