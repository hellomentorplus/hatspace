part of 'home_interaction_cubit.dart';

abstract class HomeInteractionState extends Equatable {
  const HomeInteractionState();
}

class HomeInitial extends HomeInteractionState {
  @override
  List<Object> get props => [];
}

class StartValidateRole extends HomeInteractionState {
  @override
  List<Object?> get props => [];
}

class StartAddPropertyFlow extends HomeInteractionState {
  @override
  List<Object?> get props => [];
}
