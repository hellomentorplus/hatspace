import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'authentication_service_test.mocks.dart';

@GenerateMocks([
  GoogleSignIn,
  FirebaseAuth,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  AuthCredential,
  UserCredential,
  User,
  FacebookAuth,
  AccessToken,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  FirebaseFirestore,
])
void main() {
  final MockGoogleSignIn googleSignIn = MockGoogleSignIn();
  final MockFirebaseAuth firebaseAuth = MockFirebaseAuth();
  final MockGoogleSignInAccount account = MockGoogleSignInAccount();
  final MockGoogleSignInAuthentication authentication =
      MockGoogleSignInAuthentication();
  final MockAuthCredential credential = MockAuthCredential();
  final MockUserCredential userCredential = MockUserCredential();
  final MockUser user = MockUser();
  // Facebook mock
  final MockFacebookAuth mockFacebookAuth = MockFacebookAuth();
  final MockAccessToken mockAccessToken = MockAccessToken();

  final MockFirebaseFirestore firestore = MockFirebaseFirestore();
  final MockCollectionReference<Map<String, dynamic>> collectionReference =
      MockCollectionReference();
  final MockDocumentReference<Map<String, dynamic>> documentReference =
      MockDocumentReference();
  final MockDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      MockDocumentSnapshot();
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
  setUp(() async {
    await Firebase.initializeApp();
    when(googleSignIn.signIn())
        .thenAnswer((realInvocation) => Future.value(account));
    when(account.authentication)
        .thenAnswer((realInvocation) => Future.value(authentication));
    when(authentication.accessToken).thenReturn('accessToken');
    when(authentication.idToken).thenReturn('idToken');
    when(firebaseAuth.signInWithCredential(credential))
        .thenAnswer((realInvocation) => Future.value(userCredential));
    when(userCredential.user).thenReturn(user);

    when(user.uid).thenReturn('uid');
    when(user.email).thenReturn('email@gmail.com');
    when(user.phoneNumber).thenReturn('123456');
    when(mockAccessToken.token).thenReturn("mock token");
    when(mockFacebookAuth.login()).thenAnswer((_) async {
      return Future<LoginResult>.value(LoginResult(
          status: LoginStatus.success,
          message: "Success",
          accessToken: mockAccessToken));
    });
    //
    StorageService.firestore = firestore;
  });

  test('given facebook login success', () {
    // given
    when(firebaseAuth.signInWithCredential(any))
        .thenAnswer((realInvocation) => Future.value(userCredential));
    when(mockFacebookAuth.login()).thenAnswer((realInvocation) {
      return Future<LoginResult>.value(LoginResult(
          status: LoginStatus.success,
          message: "test message",
          accessToken: mockAccessToken));
    });
    // when
    AuthenticationService service = AuthenticationService(
        firebaseAuth: firebaseAuth, facebookAuth: mockFacebookAuth);
    // then
    expect(service.signUpWithFacebook(), isA<Future<UserDetail>>());
  });

  test('given facebook login unsuccess, when login with facebook', () {
    when(mockFacebookAuth.login()).thenAnswer((_) => Future<LoginResult>.value(
        LoginResult(
            status: LoginStatus.cancelled,
            message: 'test message',
            accessToken: mockAccessToken)));
    AuthenticationService service = AuthenticationService(
        firebaseAuth: firebaseAuth, facebookAuth: mockFacebookAuth);
    expect(service.signUpWithFacebook(), throwsA(isA<UserCancelException>()));
  });

  test(
      'given facebook login and firebase user not found, when login with facbook then',
      () {
    when(firebaseAuth.signInWithCredential(any)).thenThrow(Exception());

    // when
    AuthenticationService service = AuthenticationService(
        facebookAuth: mockFacebookAuth, firebaseAuth: firebaseAuth);

    // then
    expect(
        service.onFacebookLoginSuccess(LoginResult(
            status: LoginStatus.cancelled,
            message: 'test message',
            accessToken: mockAccessToken)),
        throwsA(isA<UserNotFoundException>()));
  });

  test(
      'given google sign in fails, when sign in with google, then throw UserCancelException',
      () {
    // given
    when(googleSignIn.signIn())
        .thenAnswer((realInvocation) => Future.value(null));

    // when
    AuthenticationService service = AuthenticationService(
        googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(), throwsA(isA<UserCancelException>()));
  });

  test(
      'given Firebase Auth fails to validate google credential, when sign in with google, then throw UserNotFoundException',
      () {
    // given
    when(userCredential.user).thenReturn(null);

    // when
    AuthenticationService service = AuthenticationService(
        googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

    // then
    expect(service.signUpWithGoogle(authCredential: credential),
        throwsA(isA<UserNotFoundException>()));
  });

  test(
    'given Firebase Auth throws PlatformException, when sign in with google, then throw AuthenticationException',
    () {
      // given
      when(firebaseAuth.signInWithCredential(credential))
          .thenThrow(PlatformException(code: 'code', message: 'message'));

      // when
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      // then
      expect(service.signUpWithGoogle(authCredential: credential),
          throwsA(isA<AuthenticationException>()));
    },
  );

  test(
    'given Firebase Auth throws unknown exception, when sign in with google, then throw UnknownException',
    () {
      // given
      when(firebaseAuth.signInWithCredential(credential))
          .thenThrow(Exception());

      // when
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      // then
      expect(service.signUpWithGoogle(authCredential: credential),
          throwsA(isA<UnknownException>()));
    },
  );

  test(
    'given all validation success, when sign in with google, then return user detail',
    () async {
      // when
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      // then
      final UserDetail userDetail =
          await service.signUpWithGoogle(authCredential: credential);

      expect(userDetail.uid, user.uid);
      expect(userDetail.email, user.email);
      expect(userDetail.phone, user.phoneNumber);
    },
  );

  test(
    'given Firebase Auth return null user, when get current user, then throw UserNotFoundException',
    () {
      // given
      when(firebaseAuth.currentUser).thenReturn(null);
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      // when
      expect(service.getCurrentUser(), throwsA(isA<UserNotFoundException>()));
    },
  );

  test(
    'given Firebase Auth return user detail, when get current user, then return UserDetail',
    () async {
      // given
      when(firebaseAuth.currentUser).thenReturn(user);

      // when
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      // then
      final UserDetail userDetail = await service.getCurrentUser();

      expect(userDetail.email, user.email);
      expect(userDetail.uid, user.uid);
      expect(userDetail.phone, user.phoneNumber);
    },
  );

  group("cover signUp function", () {
    setUp(() async {
      // Firesbase auth

      when(firebaseAuth.currentUser).thenReturn(user);
      when(firebaseAuth.signInWithCredential(any))
          .thenAnswer((realInvocation) => Future.value(userCredential));
      // Storage Service
      when(firestore.collection(any))
          .thenAnswer((realInvocation) => collectionReference);
      when(collectionReference.doc(any))
          .thenAnswer((realInvocation) => documentReference);
      when(documentReference.get(any))
          .thenAnswer((realInvocation) => Future.value(documentSnapshot));

      when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
      when(documentSnapshot.data()).thenAnswer((realInvocation) => {
            'roles': ['tenant', 'homeowner']
          });
    });
    tearDown(() {
      reset(firestore);
      reset(collectionReference);
      reset(documentReference);
      reset(documentSnapshot);
    });
    test(
        "given user sign in with google service, when user sign in, then return List<Roles>",
        () async {
      AuthenticationService service = AuthenticationService(
          googleSignIn: googleSignIn, firebaseAuth: firebaseAuth);

      List<Roles> listRoles = [];
      listRoles = await service.signUp(signUpType: SignUpType.googleService);
      expect(listRoles, [Roles.tenant, Roles.homeowner]);
    });

    test(
        "given user sign in with facebook service, when user sign in, then return List<Roles>",
        () async {
      when(mockFacebookAuth.login()).thenAnswer((realInvocation) {
        return Future<LoginResult>.value(LoginResult(
            status: LoginStatus.success,
            message: "test message",
            accessToken: mockAccessToken));
      });
      AuthenticationService service = AuthenticationService(
          facebookAuth: mockFacebookAuth, firebaseAuth: firebaseAuth);
      List<Roles> listRoles = [];
      listRoles = await service.signUp(signUpType: SignUpType.facebookService);
      expect(listRoles, [Roles.tenant, Roles.homeowner]);
    });
  });
}
