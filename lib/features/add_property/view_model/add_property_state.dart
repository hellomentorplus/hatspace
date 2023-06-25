import 'package:equatable/equatable.dart';

abstract class AddPropertyState extends Equatable {
  final int pageViewNumber;
  const AddPropertyState(this.pageViewNumber);
}

class AddPropertyInitial extends AddPropertyState {
  const AddPropertyInitial() : super(0);

  @override
  List<Object?> get props => [];
}

class PageViewNavigationState extends AddPropertyState {
  const PageViewNavigationState(super.pageViewNumber);

  @override
  List<Object?> get props => [super.pageViewNumber];
}

class NextButtonEnable extends AddPropertyState {
  final bool isActive;
  const NextButtonEnable(super.pageViewNumber, this.isActive);

  @override
  List<Object?> get props => [isActive];
}

class StartListenChanges extends AddPropertyState {
  const StartListenChanges(super.pageViewNumber);

  @override
  List<Object?> get props => [];
}

class OnSaveAustraliaState extends AddPropertyState {
  const OnSaveAustraliaState(super.pageViewNumber);

  @override
  List<Object?> get props => [];
}

class OnSaveRentPeriod extends AddPropertyState {
  const OnSaveRentPeriod(super.pageViewNumber);

  @override
  List<Object?> get props => [];
}
