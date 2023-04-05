part of 'choose_role_view_bloc.dart';

abstract class ChooseRoleViewEvent extends Equatable {
  const ChooseRoleViewEvent();

  @override
  List<Object> get props => [];
}

class OnChangeUserRoleEvent extends ChooseRoleViewEvent {
  final int position;
  const OnChangeUserRoleEvent(this.position);
  @override
  List<Object> get props => [];
}