part of 'sign_up_bloc.dart';

abstract class FirstLaunchAppState extends Equatable {
  const FirstLaunchAppState();

  @override
  List<Object> get props => [];
}

class FirstLaunchAppInitState extends FirstLaunchAppState {}

class ShowFirstSignUp extends FirstLaunchAppState {}

class ShowHomeView extends FirstLaunchAppState {}
