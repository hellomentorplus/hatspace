part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {
  const ProfileInitialState();
}

class GettingUserDetailState extends ProfileState {
  const GettingUserDetailState();
}

class GetUserDetailSucceedState extends ProfileState {
  final UserDetail user;
  final List<Roles> roles;
  const GetUserDetailSucceedState(this.user, this.roles);

  @override
  List<Object?> get props => [user, ...roles];
}

class GetUserDetailFailedState extends ProfileState {
  const GetUserDetailFailedState();
}

class LogOutAccountSucceedState extends ProfileState {
  const LogOutAccountSucceedState();
}
