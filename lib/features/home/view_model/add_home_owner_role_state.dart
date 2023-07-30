part of 'add_home_owner_role_cubit.dart';

abstract class AddHomeOwnerRoleState extends Equatable {
  const AddHomeOwnerRoleState();
}

class AddHomeOwnerRoleInitial extends AddHomeOwnerRoleState {
  @override
  List<Object> get props => [];
}

class AddHomeOwnerRoleSucceeded extends AddHomeOwnerRoleState {
  @override
  List<Object?> get props => [];
}

class AddHomeOwnerRoleError extends AddHomeOwnerRoleState {
  @override
  List<Object?> get props => [];
}
