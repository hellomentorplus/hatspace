import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_config_bloc_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Testing Firebase Remote Config', () {
    MockFirebaseRemoteConfig firebaseRemoteMock = MockFirebaseRemoteConfig();
    blocTest<AppConfigBloc, AppConfigState>(
      'Testing Debug Option from Firebase Remote Config',
      build: () {
        return AppConfigBloc(firebaseRemoteConfig: firebaseRemoteMock);
      },
      setUp: () async {
        await firebaseRemoteMock.ensureInitialized();
        when(firebaseRemoteMock.lastFetchStatus)
            .thenReturn(RemoteConfigFetchStatus.success);
        when(firebaseRemoteMock.fetchAndActivate()).thenAnswer((_) {
          return Future.value(true);
        });
        when(firebaseRemoteMock.getBool('debug_option_enabled'))
            .thenReturn(true);
      },
      act: ((bloc) {
        return bloc.add(const OnInitialRemoteConfig());
      }),
      expect: () {
        return [const DebugOptionEnabledState(debugOptionEnabled: true)];
      },
    );
  });

  test('test state and event', () {
    OnInitialRemoteConfig event = const OnInitialRemoteConfig();

    expect(event.props.length, 0);

    AppConfigInitialState initialState = const AppConfigInitialState();
    expect(initialState.props.length, 0);
  });
}
