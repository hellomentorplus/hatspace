import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/view_models/app_config/app_config_event.dart';
import 'package:hatspace/view_models/app_config/app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  final FirebaseRemoteConfig _firebaseRemoteConfig;
  AppConfigBloc({FirebaseRemoteConfig? firebaseRemoteConfig})
      : _firebaseRemoteConfig =
            firebaseRemoteConfig ?? FirebaseRemoteConfig.instance,
        super(const AppConfigInitialState()) {
    on<OnInitialRemoteConfig>((event, emit) async {
      // Initial Remote Config
      await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 0),
          minimumFetchInterval: const Duration(seconds: 0)));
      _firebaseRemoteConfig.ensureInitialized();
      await _firebaseRemoteConfig.fetchAndActivate();

      bool debugOptionEnable =
          _firebaseRemoteConfig.getBool("debug_option_enabled");
      emit(DebugOptionEnabledState(debugOptionEnabled: debugOptionEnable));
    });
  }
}
