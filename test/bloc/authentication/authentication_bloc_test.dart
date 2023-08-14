import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationService])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);

    when(authenticationService.signOut())
        .thenAnswer((realInvocation) => Future.value());

    when(authenticationService.authenticationState)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  blocTest<AuthenticationBloc, AuthenticationState>(
    'Return RequestSignUp state with isFirstLaunch is true when first open app with OnAppLaunchValidation event',
    build: () => AuthenticationBloc(),
    act: ((bloc) {
      SharedPreferences.setMockInitialValues({});
      bloc.add(OnAppLaunchValidation());
    }),
    expect: () {
      return [RequestSignUp()];
    },
    verify: (bloc) {
      verify(authenticationService.signOut()).called(1);
    },
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'Return AnonymousState when trigger SkipSignUp Event',
    build: () => AuthenticationBloc(),
    act: (authenticationBloc) {
      SharedPreferences.setMockInitialValues({});
      authenticationBloc.add(SkipSignUp());
    },
    expect: () {
      return [AnonymousState()];
    },
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
      'given isAppleSignInAvailable is true and platform is iOS, '
      'when isAppleSignInAvailable is called, '
      'then return AppleSignInAvailable',
      build: () => AuthenticationBloc(),
      setUp: () {
        when(authenticationService.isAppleSignInAvailable())
            .thenAnswer((_) => Future.value(true));
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      },
      act: (authenticationBloc) {
        authenticationBloc.add(CheckAppleSignInAvailable());
      },
      expect: () {
        return [const AppleSignInAvailable()];
      },
      tearDown: () {
        debugDefaultTargetPlatformOverride = null;
      });

  blocTest<AuthenticationBloc, AuthenticationState>(
      'given isAppleSignInAvailable is true and platform is android, '
      'when isAppleSignInAvailable is called, '
      'then return nothing',
      build: () => AuthenticationBloc(),
      setUp: () {
        when(authenticationService.isAppleSignInAvailable())
            .thenAnswer((_) => Future.value(true));
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
      },
      act: (authenticationBloc) {
        authenticationBloc.add(CheckAppleSignInAvailable());
      },
      expect: () {
        return [];
      },
      tearDown: () {
        debugDefaultTargetPlatformOverride = null;
      });

  blocTest<AuthenticationBloc, AuthenticationState>(
      'given isAppleSignInAvailable is false and platform is iOS, '
      'when isAppleSignInAvailable is called, '
      'then return nothing',
      build: () => AuthenticationBloc(),
      setUp: () {
        when(authenticationService.isAppleSignInAvailable())
            .thenAnswer((_) => Future.value(false));
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      },
      act: (authenticationBloc) {
        authenticationBloc.add(CheckAppleSignInAvailable());
      },
      expect: () {
        return [];
      },
      tearDown: () {
        debugDefaultTargetPlatformOverride = null;
      });

  blocTest<AuthenticationBloc, AuthenticationState>(
      'given isAppleSignInAvailable is false and platform is android, '
      'when isAppleSignInAvailable is called, '
      'then return nothing',
      build: () => AuthenticationBloc(),
      setUp: () {
        when(authenticationService.isAppleSignInAvailable())
            .thenAnswer((_) => Future.value(false));
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
      },
      act: (authenticationBloc) {
        authenticationBloc.add(CheckAppleSignInAvailable());
      },
      expect: () {
        return [];
      },
      tearDown: () {
        debugDefaultTargetPlatformOverride = null;
      });
}
