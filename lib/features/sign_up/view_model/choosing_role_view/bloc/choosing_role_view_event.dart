part of 'choosing_role_view_bloc.dart';

abstract class ChoosingRoleViewEvent extends Equatable {
  const ChoosingRoleViewEvent();

  @override
  List<Object> get props => [];
}

class OnChangeUserRoleEvent extends ChoosingRoleViewEvent {
  final int position;
  const OnChangeUserRoleEvent(this.position);
  @override
  List<Object> get props => [];
}
