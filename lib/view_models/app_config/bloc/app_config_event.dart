part of 'app_config_bloc.dart';

abstract class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object> get props => [];
}

class OnInitialRemoteConfig extends AppConfigEvent {
  const OnInitialRemoteConfig();
}
