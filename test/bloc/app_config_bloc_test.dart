import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/models/remote_config/remote_config_service.dart';
import 'package:hatspace/view_models/app_config/app_config_bloc.dart';
import 'package:hatspace/view_models/app_config/app_config_event.dart';
import 'package:hatspace/view_models/app_config/app_config_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../firebase_core_mock.dart';
import 'app_config_bloc_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig, RemoteConfigService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  group("Testing Firebase Remote Config", () {
    MockFirebaseRemoteConfig firebaseRemoteMock = MockFirebaseRemoteConfig();
    blocTest<AppConfigBloc, AppConfigState>(
      "Testing Debug Option from Firebase Remote Config",
      build: () {
        return AppConfigBloc(firebaseRemoteConfig: firebaseRemoteMock);
      },
      setUp: () async {
        await firebaseRemoteMock.ensureInitialized();
        when(firebaseRemoteMock.fetchAndActivate()).thenAnswer((_) {
          return Future.value(true);
        });
        when(firebaseRemoteMock.getBool("debug_option_enabled"))
            .thenReturn(true);
      },
      act: ((bloc) {
        return bloc.add(const OnInitialRemoteConfig());
      }),
      expect: () {
        return [DebugOptionEnabledState(debugOptionEnabled: true)];
      },
    );
  });
}
