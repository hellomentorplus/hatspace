part of 'choose_role_bloc.dart';

abstract class ChooseRoleState extends Equatable {
  const ChooseRoleState();

  @override
  List<Object> get props => [];
}

class ChoosingRoleState extends ChooseRoleState {
  final Set<Roles> roles;
  const ChoosingRoleState({this.roles = const {}});
  @override
  List<Object> get props => [...roles];
}

class SubmittingRoleState extends ChooseRoleState {
  const SubmittingRoleState();
}

class SubmitRoleSucceedState extends ChooseRoleState {
  const SubmitRoleSucceedState();
}

class SubmitRoleFailedState extends ChooseRoleState {
  const SubmitRoleFailedState();
}
