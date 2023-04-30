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
  final Set<Roles> listRole;
  const UserRoleSelectedListState(this.listRole);
  @override
  List<Object> get props => [listRole];
}

class ChoosingRoleSuccessState extends ChooseRoleViewState {
  @override
  List<Object> get props => [];
}

class ChoosingRoleFail extends ChooseRoleViewState{
  @override
  List<Object> get props => [];
}