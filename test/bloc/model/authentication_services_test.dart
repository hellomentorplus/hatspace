import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_services_test.mocks.dart';

@GenerateMocks([
  AuthenticationService,
  FirebaseAuth,
  FacebookAuth,
  AccessToken,
  User,
  FacebookAuthCredential,
  UserCredential,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockFacebookAuth mockFacebookAuth = MockFacebookAuth();
  final MockAuthenticationService mockAuthenticationService =
      MockAuthenticationService();
  final AuthenticationService service = AuthenticationService(
      firebaseAuth: mockFirebaseAuth, facebookAuth: mockFacebookAuth);

  final MockUserCredential mockUserCredential = MockUserCredential();
  final MockAccessToken mockAccessToken = MockAccessToken();
  final MockUser mockUser = MockUser();
  // STUB Firebase authentication
  group("Bloc Test Facebook Sign In Function To Return Success state ", () {
    // Stub Facebook login
    blocTest<SignUpBloc, SignUpState>(
        "Success Facebook Login with return SingUpState", build: () {
      return SignUpBloc(authenticationService: mockAuthenticationService);
    }, setUp: () {
      final UserDetail testUserDetail =
          UserDetail(uid: "test uid", phone: "test phone", email: "test email");
      when(mockAuthenticationService.signUpWithFacebook()).thenAnswer((_) {
        return Future<UserDetail>.value(testUserDetail);
      });
    }, act: (bloc) {
      bloc.add(const SignUpWithFacebook());
    }, expect: () {
      return [isA<SignUpSuccess>()];
    });
  });

  test("Test Facebook SignIn function in service ", () {
    // Prepare for LoginResult with accessToken properties
    when(mockFacebookAuth.accessToken).thenAnswer((_) {
      return Future<AccessToken?>.value();
    });
    when(mockAccessToken.token).thenReturn("mock token");

    when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) {
      return Future<UserCredential>.value(mockUserCredential);
    });
    // Prepare value for mockUser to return UserDetail in signUpFirebase function
    when(mockUser.uid).thenReturn("mock uid");
    when(mockUser.phoneNumber).thenReturn('mock phone number');
    when(mockUser.email).thenReturn("mock email");
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    // Mock facebookAuth login function
    when(mockFacebookAuth.login()).thenAnswer((_) async {
      return Future<LoginResult>.value(LoginResult(
          status: LoginStatus.success,
          message: "Success",
          accessToken: mockAccessToken));
    });
    expect(service.signUpWithFacebook(), isA<Future<UserDetail?>>());
  });
}
