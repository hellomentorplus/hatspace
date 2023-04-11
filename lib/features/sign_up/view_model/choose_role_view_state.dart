import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';

abstract class ChooseRoleViewState extends Equatable {
  const ChooseRoleViewState();

  @override
  List<Object> get props => [];
}

class ChooseRoleViewInitial extends ChooseRoleViewState {}

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
