import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/models/remote_config/remote_config_service.dart';
import 'package:hatspace/view_models/app_config_event.dart';
import 'package:hatspace/view_models/app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc() : super(const AppConfigInitialState()) {
    on<OnInitialRemoteConfig>((event, emit) {
      // Initial Remote Config
      RemoteConfigService remoteConfigService = RemoteConfigService();
      remoteConfigService.initialise();
      bool debugOptionEnable = remoteConfigService.getDebugOption();
      emit(DebugOptionEnabledState(debugOptionEnabled: debugOptionEnable));
    });
  }
}
