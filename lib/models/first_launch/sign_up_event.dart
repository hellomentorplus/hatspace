part of 'sign_up_bloc.dart';

abstract class FirstLaunchEvent extends Equatable {
  const FirstLaunchEvent();

  @override
  List<Object> get props => [];
}

class FirstLoad extends FirstLaunchEvent {}
