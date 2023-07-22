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

    when(authenticationService.authenticationState).thenAnswer((realInvocation) => Stream.empty());
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
    act: (signUpBloc) {
      SharedPreferences.setMockInitialValues({});
      signUpBloc.add(SkipSignUp());
    },
    expect: () {
      return [AnonymousState()];
    },
  );
}
