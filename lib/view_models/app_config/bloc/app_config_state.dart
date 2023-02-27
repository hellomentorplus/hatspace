import 'package:equatable/equatable.dart';

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
  bool debugOptionEnabled;
  DebugOptionEnabledState({bool? debugOptionEnabled})
      : debugOptionEnabled = debugOptionEnabled ?? false;
  @override
  List<Object> get props => [debugOptionEnabled];
}
