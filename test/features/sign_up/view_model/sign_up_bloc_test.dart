import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'sign_up_bloc_test.mocks.dart';

@GenerateMocks([
  AuthenticationService,
  StorageService,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  MemberService
])
void main() async {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockMemberService memberService = MockMemberService();
  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  //setupFirebaseAuthMocks(); // Not relate to HS 51 - Need to add to perform test coverage
  group('Sign_up_bloc test state', () {
    late SignUpBloc signUpBloc;
    setUpAll(() async {
      // Unexpected bugs - happended when running test coverage
      signUpBloc = SignUpBloc();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
              const MethodChannel('plugins.flutter.io/shared_preferences'),
              (MethodCall methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{}; // set initial values here if desired
        }
        return null;
      });
    });
    test('initial test', () {
      expect(SignUpBloc().state, const SignUpInitial());
    });

    tearDown(() {
      signUpBloc.close();

      reset(storageServiceMock);
      reset(memberService);
      reset(authenticationService);
    });
  });

  group('Check User Roles availability', () {
    setUp(() {
      when(storageServiceMock.member).thenAnswer((realInvocation) {
        return memberService;
      });
    });

    tearDown(() {
      reset(storageServiceMock);
      reset(memberService);
      reset(authenticationService);
    });

    blocTest(
        'when user sign up success with google and user already had roles then system will check userrole and return list of role ',
        build: () => SignUpBloc(),
        setUp: () {
          when(authenticationService.signUp(
                  signUpType: SignUpType.googleService))
              .thenAnswer((realInvocation) => Future.value(UserDetail(
                  uid: 'mock uid', phone: 'mock phone', email: 'mock email')));

          when(memberService.getUserRoles(any))
              .thenAnswer((realInvocation) => Future.value([Roles.tenant]));

          when(memberService.saveNameAndAvatar(any, any, any))
              .thenAnswer((realInvocation) => Future.value());

          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
              .setMockMethodCallHandler(
                  const MethodChannel('plugins.flutter.io/shared_preferences'),
                  (MethodCall methodCall) async {
            if (methodCall.method == 'getAll') {
              return <String, dynamic>{}; // set initial values here if desired
            }

            expect(methodCall.method, 'setBool');
            expect(methodCall.arguments,
                {'key': 'flutter.isFirstLaunch', 'value': false});

            if (methodCall.method == 'setBool') {
              return true;
            }
            return null;
          });
        },
        act: (bloc) => bloc.add(const SignUpWithGoogle()),
        expect: () => [isA<SignUpStart>(), isA<SignUpSuccess>()]);

    blocTest(
      'when user sign up success with google and user has not had roles yet, then system will check userrole and return empty list',
      build: () => SignUpBloc(),
      setUp: () {
        when(authenticationService.signUp(signUpType: SignUpType.googleService))
            .thenAnswer((realInvocation) => Future.value(UserDetail(
                uid: 'test uid', phone: 'test phone', email: 'test email')));
        when(memberService.getUserRoles(any))
            .thenAnswer((realInvocation) => Future.value([]));
      },
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<SignUpStart>(), isA<UserRolesUnavailable>()],
    );
  });

  group('Test sign up failed', () {
    // WITH GOOGLE SIGN UP TYPE
    blocTest(
      'when sign up with google failed with UserCancelException, then return UserCancelled',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUp(
              signUpType: SignUpType.googleService))
          .thenThrow(UserCancelException()),
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<SignUpStart>(), isA<UserCancelled>()],
    );
    blocTest(
        'when signup with google failed with UserNotFoundException, then return AuthenticationFailed',
        build: () => SignUpBloc(),
        setUp: () => when(authenticationService.signUp(
                signUpType: SignUpType.googleService))
            .thenThrow(UserNotFoundException()),
        act: (bloc) => bloc.add(const SignUpWithGoogle()),
        expect: () => [isA<SignUpStart>(), isA<AuthenticationFailed>()]);
    blocTest(
      'when signup with google failed with unknown error, then return AuthenticationFailed',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUp(
              signUpType: SignUpType.googleService))
          .thenThrow(PlatformException(code: '1234')),
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<SignUpStart>(), isA<AuthenticationFailed>()],
    );

    // WITH FACEBOOK SIGN UP
    blocTest(
      'when sign up with google failed with UserCancelException, then return UserCancelled',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUp(
              signUpType: SignUpType.facebookService))
          .thenThrow(UserCancelException()),
      act: (bloc) => bloc.add(const SignUpWithFacebook()),
      expect: () => [isA<SignUpStart>(), isA<UserCancelled>()],
    );
    blocTest(
        'when signup with google failed with UserNotFoundException, then return AuthenticationFailed',
        build: () => SignUpBloc(),
        setUp: () => when(authenticationService.signUp(
                signUpType: SignUpType.facebookService))
            .thenThrow(UserNotFoundException()),
        act: (bloc) => bloc.add(const SignUpWithFacebook()),
        expect: () => [isA<SignUpStart>(), isA<AuthenticationFailed>()]);
    blocTest(
      'when signup with google failed with unknown error, then return AuthenticationFailed',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUp(
              signUpType: SignUpType.facebookService))
          .thenThrow(PlatformException(code: '1234')),
      act: (bloc) => bloc.add(const SignUpWithFacebook()),
      expect: () => [isA<SignUpStart>(), isA<AuthenticationFailed>()],
    );
  });
  test('test state and event', () {
    SignUpInitial signUpInitial = const SignUpInitial();
    expect(signUpInitial.props.length, 0);

    UserRolesUnavailable userRolesUnavailable = const UserRolesUnavailable();
    expect(userRolesUnavailable.props.length, 0);

    SignUpSuccess signUpSuccess = const SignUpSuccess();
    expect(signUpSuccess.props.length, 0);

    SignUpWithGoogle signUpWithGoogle = const SignUpWithGoogle();
    expect(signUpWithGoogle.props.length, 0);

    SignUpWithFacebook signUpWithFacebook = const SignUpWithFacebook();
    expect(signUpWithFacebook.props.length, 0);
  });
}
