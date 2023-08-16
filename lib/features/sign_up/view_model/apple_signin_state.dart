part of 'apple_signin_cubit.dart';

abstract class AppleSignInState extends Equatable {
  const AppleSignInState();

  @override
  List<Object> get props => [];
}

class AppleSignInInitial extends AppleSignInState {}

class AppleSignInAvailable extends AppleSignInState {}
