part of 'choosing_role_view_bloc.dart';

abstract class ChoosingRoleViewState extends Equatable {
  const ChoosingRoleViewState();
  
  @override
  List<Object> get props => [];
}

class ChoosingRoleViewInitial extends ChoosingRoleViewState {}

class StartListenRoleChange extends ChoosingRoleViewState {
  const StartListenRoleChange();
  @override
  List<Object> get props => [];
}

class UserRoleSelectedListState extends ChoosingRoleViewState {
  final List<Roles> listRole;
  const UserRoleSelectedListState(this.listRole);
  @override
  List<Roles> get props => listRole;
}
