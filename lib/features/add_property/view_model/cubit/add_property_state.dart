
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/data.dart';

// class PropertyTypeState  {
//   PropertyTypes propertyTypes;
//   DateTime availableDate;
//   PropertyTypeState(this.propertyTypes, this.availableDate);
// }

abstract class AddPropertyState{  
  int pageViewNumber;
  // PropertyTypeState propertyTypeState;
  AddPropertyState( this.pageViewNumber);
}

class AddPropertyInitial extends AddPropertyState {
  AddPropertyInitial() : super(0);
}


class PageViewNavigationState extends AddPropertyState{
  PageViewNavigationState(super.pageViewNumber);
}

class NextButtonEnable extends AddPropertyState{
  NextButtonEnable( super.pageViewNumber);
}

