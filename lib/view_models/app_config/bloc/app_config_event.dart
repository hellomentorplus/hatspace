import 'package:equatable/equatable.dart';

abstract class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object> get props => [];
}

class OnInitialRemoteConfig extends AppConfigEvent {
  const OnInitialRemoteConfig();
}
