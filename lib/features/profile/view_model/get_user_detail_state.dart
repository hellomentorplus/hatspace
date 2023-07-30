part of 'get_user_detail_cubit.dart';

abstract class GetUserDetailState extends Equatable {
  const GetUserDetailState();

  @override
  List<Object?> get props => [];
}

class GetUserDetailInitialState extends GetUserDetailState {
  const GetUserDetailInitialState();
}

class GettingUserDetailState extends GetUserDetailState {
  const GettingUserDetailState();
}

class GetUserDetailSucceedState extends GetUserDetailState {
  final UserDetail user;
  const GetUserDetailSucceedState(this.user);

  @override
  List<Object?> get props => [user];
}

class GetUserDetailFailedState extends GetUserDetailState {
  const GetUserDetailFailedState();
}

class GettingUserRolesState extends GetUserDetailState {
  const GettingUserRolesState();
}

class GetUserRolesSucceedState extends GetUserDetailState {
  final List<Roles> roles;
  const GetUserRolesSucceedState(this.roles);

  @override
  List<Object?> get props => roles;
}

class GetUserRolesFailedState extends GetUserDetailState {
  const GetUserRolesFailedState();
}
