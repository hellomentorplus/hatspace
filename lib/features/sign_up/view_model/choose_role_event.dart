part of 'choose_role_bloc.dart';

abstract class ChooseRoleEvent extends Equatable {
  const ChooseRoleEvent();

  @override
  List<Object> get props => [];
}

class ChangeRoleEvent extends ChooseRoleEvent {
  final Roles role;
  const ChangeRoleEvent(this.role);

  @override
  List<Object> get props => [role];
}

class SubmitRoleEvent extends ChooseRoleEvent {
  const SubmitRoleEvent();
}
