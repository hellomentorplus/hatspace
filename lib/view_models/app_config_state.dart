import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hatspace/models/remote_config/remote_config_service.dart';

abstract class AppConfigState extends Equatable {
  const AppConfigState();
  @override
  List<Object> get props => [];
}

class AppConfigInitialState extends AppConfigState {
  const AppConfigInitialState();
  @override
  List<Object> get props => [];
}

class RemoteConfigInitialised extends AppConfigState {
  const RemoteConfigInitialised();
}

class DebugOptionEnabledState extends AppConfigState {
  bool debugOptionEnabled;
  DebugOptionEnabledState({bool? debugOptionEnabled})
      : debugOptionEnabled = debugOptionEnabled ?? false;
}
