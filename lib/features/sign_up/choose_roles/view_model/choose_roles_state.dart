part of 'choose_roles_cubit.dart';

abstract class ChooseRolesState extends Equatable {
  const ChooseRolesState();

  @override
  List<Object> get props => [];
}

class ChoosingRolesState extends ChooseRolesState {
  final Set<Roles> roles;
  const ChoosingRolesState({this.roles = const {}});
  @override
  List<Object> get props => [...roles];
}

class SubmittingRoleState extends ChooseRolesState {
  const SubmittingRoleState();
}

class SubmitRoleSucceedState extends ChooseRolesState {
  const SubmitRoleSucceedState();
}

class SubmitRoleFailedState extends ChooseRolesState {
  const SubmitRoleFailedState();
}
