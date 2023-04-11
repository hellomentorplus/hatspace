import 'package:equatable/equatable.dart';

abstract class ChooseRoleViewEvent extends Equatable {
  const ChooseRoleViewEvent();
}

class OnChangeUserRoleEvent extends ChooseRoleViewEvent {
  final int position;
  const OnChangeUserRoleEvent(this.position);
  @override
  List<Object> get props => [];
}
