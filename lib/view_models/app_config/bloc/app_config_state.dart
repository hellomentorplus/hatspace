part of 'app_config_bloc.dart';

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

class DebugOptionEnabledState extends AppConfigState {
  final bool debugOptionEnabled;
  const DebugOptionEnabledState({bool? debugOptionEnabled})
      : debugOptionEnabled = debugOptionEnabled ?? false;
  @override
  List<Object> get props => [debugOptionEnabled];
}
