part of 'my_profile_cubit.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object?> get props => [];
}

class MyProfileInitialState extends MyProfileState {
  const MyProfileInitialState();
}

class GettingUserInformationState extends MyProfileState {
  const GettingUserInformationState();
}

class GetUserInformationSucceedState extends MyProfileState {
  final UserDetail user;
  const GetUserInformationSucceedState(this.user);
}

class GetUserInformationFailedState extends MyProfileState {
  const GetUserInformationFailedState();
}
