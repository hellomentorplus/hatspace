import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view_model/apple_signin_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../bloc/authentication/authentication_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationService])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  blocTest<AppleSignInCubit, AppleSignInState>(
      'given AppleSignIn is Available and platform is iOS, '
      'when checkAppleSignInAvailable, '
      'then return AppleSignInAvailable',
      build: () => AppleSignInCubit(),
      setUp: () {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        when(authenticationService.isAppleSignInAvailable).thenReturn(true);
      },
      act: (cubit) => cubit.checkAppleSignInAvailable(),
      expect: () => [AppleSignInAvailable()],
      tearDown: () => debugDefaultTargetPlatformOverride = null);

  blocTest<AppleSignInCubit, AppleSignInState>(
      'given AppleSignIn is NOT Available and platform is iOS, '
      'when checkAppleSignInAvailable, '
      'then return nothing',
      build: () => AppleSignInCubit(),
      setUp: () {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        when(authenticationService.isAppleSignInAvailable).thenReturn(false);
      },
      act: (cubit) => cubit.checkAppleSignInAvailable(),
      expect: () => [],
      tearDown: () => debugDefaultTargetPlatformOverride = null);

  blocTest<AppleSignInCubit, AppleSignInState>(
      'given AppleSignIn is Available and platform is android, '
      'when checkAppleSignInAvailable, '
      'then return nothing',
      build: () => AppleSignInCubit(),
      setUp: () {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        when(authenticationService.isAppleSignInAvailable).thenReturn(true);
      },
      act: (cubit) => cubit.checkAppleSignInAvailable(),
      expect: () => [],
      tearDown: () => debugDefaultTargetPlatformOverride = null);

  blocTest<AppleSignInCubit, AppleSignInState>(
      'given AppleSignIn is NOT Available and platform is android, '
      'when checkAppleSignInAvailable, '
      'then return nothing',
      build: () => AppleSignInCubit(),
      setUp: () {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        when(authenticationService.isAppleSignInAvailable).thenReturn(false);
      },
      act: (cubit) => cubit.checkAppleSignInAvailable(),
      expect: () => [],
      tearDown: () => debugDefaultTargetPlatformOverride = null);
}
