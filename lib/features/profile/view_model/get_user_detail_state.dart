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
  final List<Roles> roles;
  const GetUserDetailSucceedState(this.user, this.roles);

  @override
  List<Object?> get props => [user, ...roles];
}

class GetUserDetailFailedState extends GetUserDetailState {
  const GetUserDetailFailedState();
}
