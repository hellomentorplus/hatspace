import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_service_test.mocks.dart';

@GenerateMocks([GoogleSignIn, FirebaseAuth, GoogleSignInAccount, GoogleSignInAuthentication, AuthCredential, UserCredential, User])
void main() {

  final MockGoogleSignIn googleSignIn = MockGoogleSignIn();
  final MockFirebaseAuth firebaseAuth = MockFirebaseAuth();
  final MockGoogleSignInAccount account = MockGoogleSignInAccount();
  final MockGoogleSignInAuthentication authentication = MockGoogleSignInAuthentication();
  final MockAuthCredential credential = MockAuthCredential();
  final MockUserCredential userCredential = MockUserCredential();
  final MockUser user = MockUser();

  setUp(() {
    when(googleSignIn.signIn()).thenAnswer((realInvocation) => Future.value(account));
    when(account.authentication).thenAnswer((realInvocation) => Future.value(authentication));
    when(authentication.accessToken).thenReturn('accessToken');
    when(authentication.idToken).thenReturn('idToken');
    when(firebaseAuth.signInWithCredential(credential)).thenAnswer((realInvocation) => Future.value(userCredential));
    when(userCredential.user).thenReturn(user);

    when(user.uid).thenReturn('uid');
    when(user.email).thenReturn('email@gmail.com');
    when(user.phoneNumber).thenReturn('123456');
  });

  test('given google sign in fails, when sign in with google, then throw UserCancelException', () {
    // given
    when(googleSignIn.signIn()).thenAnswer((realInvocation) => Future.value(null));

    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(), throwsA(isA<UserCancelException>()));
  });

  test('given Firebase Auth fails to validate google credential, when sign in with google, then throw UserNotFoundException', () {
    // given
    when(userCredential.user).thenReturn(null);

    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(authCredential: credential), throwsA(isA<UserNotFoundException>()));
  });

  test('given Firebase Auth throws PlatformException, when sign in with google, then throw AuthenticationException', () {
    // given
    when(firebaseAuth.signInWithCredential(credential)).thenThrow(PlatformException(code: 'code', message: 'message'));

    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(authCredential: credential), throwsA(isA<AuthenticationException>()));
  },);

  test('given Firebase Auth throws unknown exception, when sign in with google, then throw UnknownException', () {
    // given
    when(firebaseAuth.signInWithCredential(credential)).thenThrow(Exception());

    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(authCredential: credential), throwsA(isA<UnknownException>()));
  },);

  test('given all validation success, when sign in with google, then return user detail', () async {
    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    final UserDetail userDetail = await service.signUpWithGoogle(authCredential: credential);

    expect(userDetail.uid, user.uid);
    expect(userDetail.email, user.email);
    expect(userDetail.phone, user.phoneNumber);
  },);

  test('given Firebase Auth return null user, when get current user, then throw UserNotFoundException', () {
    // given
    when(firebaseAuth.currentUser).thenReturn(null);
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // when
    expect(service.getCurrentUser(), throwsA(isA<UserNotFoundException>()));
  },);

  test('given Firebase Auth return user detail, when get current user, then return UserDetail', () async {
    // given
    when(firebaseAuth.currentUser).thenReturn(user);

    // when
    AuthenticationService service = AuthenticationService(googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    final UserDetail userDetail = await service.getCurrentUser();

    expect(userDetail.email, user.email);
    expect(userDetail.uid, user.uid);
    expect(userDetail.phone, user.phoneNumber);
  },);
}