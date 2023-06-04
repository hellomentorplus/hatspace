import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/data.dart';

// class PropertyTypeState  {
//   PropertyTypes propertyTypes;
//   DateTime availableDate;
//   PropertyTypeState(this.propertyTypes, this.availableDate);
// }

abstract class AddPropertyState extends Equatable {
  final int pageViewNumber;
  // PropertyTypeState propertyTypeState;
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
  // TODO: implement props
  List<Object?> get props => [super.pageViewNumber];
}

class NextButtonEnable extends AddPropertyState {
  final bool isActive;
  const NextButtonEnable(super.pageViewNumber, this.isActive);

  @override
  // TODO: implement props
  List<Object?> get props => [isActive];
}
