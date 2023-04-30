import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';

abstract class ChooseRoleViewEvent extends Equatable {
  const ChooseRoleViewEvent();
}

class OnChangeUserRoleEvent extends ChooseRoleViewEvent {
  final int position;
  const OnChangeUserRoleEvent(this.position);
  @override
  List<Object> get props => [position];
}

class OnSubmitRoleEvent extends ChooseRoleViewEvent {
  final Set<Roles> listRoles;
  const OnSubmitRoleEvent(this.listRoles);
  @override
  List<Object> get props => [listRoles];
}