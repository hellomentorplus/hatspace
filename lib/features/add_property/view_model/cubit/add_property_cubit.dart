import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';

enum NavigatePage { forward, preverse }

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(AddPropertyInitial());

  void navigatePage(NavigatePage navType, List<Widget> listOfPages) {
    print(state.pageViewNumber);
    if (navType == NavigatePage.forward &&
        state.pageViewNumber < listOfPages.length - 1) {
      emit(PageViewNavigationState(state.pageViewNumber + 1));
    }
    if (navType == NavigatePage.preverse && state.pageViewNumber > 0) {
      emit(PageViewNavigationState(state.pageViewNumber - 1));
    }
  }

  void enableNextButton() {
    print("enable next button");
    emit(NextButtonEnable(state.pageViewNumber, true));
  }
}
