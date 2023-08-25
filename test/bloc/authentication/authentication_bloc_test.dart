import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationService, StorageService, MemberService])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);

    when(authenticationService.signOut())
        .thenAnswer((realInvocation) => Future.value());

    when(authenticationService.authenticationState)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(storageService.member).thenReturn(memberService);
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
