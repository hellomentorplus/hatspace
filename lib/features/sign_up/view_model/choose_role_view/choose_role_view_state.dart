part of 'choose_role_view_bloc.dart';

abstract class ChooseRoleViewState extends Equatable {
  const ChooseRoleViewState();
  
  @override
  List<Object> get props => [];
}

class ChooseRoleViewInitial extends ChooseRoleViewState {}


class UserRoleCardViewInitial extends ChooseRoleViewState {
  const UserRoleCardViewInitial();
}

class SelectRoleState extends ChooseRoleViewState {
  const SelectRoleState();

  @override
  List<Object> get props => [];
}

class StartListenRoleChange extends ChooseRoleViewState {
  const StartListenRoleChange();
  @override
  List<Object> get props => [];
}

class UserRoleSelectedListState extends ChooseRoleViewState {
  final List<Roles> listRole;
  const UserRoleSelectedListState(this.listRole);
  @override
  List<Roles> get props => listRole;
}