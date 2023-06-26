import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_property_cubit_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();
  initializeDateFormatting();
  setUp(() {
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());
    when(addPropertyCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const AddPropertyInitial()));
  });
  blocTest(
    "Given when user press NEXT button when it's enable, then update Page view navigation, and update next button validation",
    build: () => AddPropertyCubit(),
    act: (bloc) => {bloc.navigatePage(NavigatePage.forward, 2)},
    expect: () => [isA<PageViewNavigationState>(), isA<NextButtonEnable>()],
  );

  blocTest(
    "Given when user press BACK button when it's enable, then update new state",
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.navigatePage(NavigatePage.forward, 2);
      bloc.validateNextButtonState(0);
      bloc.navigatePage(NavigatePage.reverse, 2);
    },
    expect: () => [
      isA<PageViewNavigationState>(),
      isA<NextButtonEnable>(),
      isA<PageViewNavigationState>(),
      isA<NextButtonEnable>()
    ],
  );

  blocTest(
    'Given page is What kind of place, when validate next button, then emit NextButton true',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.validateNextButtonState(0);
    },
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is rooms info, and no room added, when validate next button, then emit NextButton false',
    build: () => AddPropertyCubit(),
    act: (bloc) => bloc.validateNextButtonState(2),
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, false);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  blocTest(
    'given page is rooms info, and rooms are added, when validate next button, then emit NextButton false',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      // set rooms number
      bloc.parking = 1;
      bloc.bedrooms = 1;
      bloc.validateNextButtonState(2);
    },
    expect: () => [isA<NextButtonEnable>()],
    verify: (bloc) {
      AddPropertyState state = bloc.state;
      expect(state, isA<NextButtonEnable>());

      NextButtonEnable nextButtonEnable = state as NextButtonEnable;
      expect(nextButtonEnable.isActive, true);
      expect(nextButtonEnable.pageViewNumber, 0);
    },
  );

  test('test initial state', () {
    AddPropertyInitial addPropertyInitial = const AddPropertyInitial();
    expect(addPropertyInitial.props.length, 0);
  });

  // blocTest(
  //   "Given when user select property type, then emit update AddPropertyState with new property tyep",
  //   build: () => PropertyTypeCubit(),
  //   act: (bloc) => {bloc.selectAvailableDate(DateTime.now())},
  //   expect: () => [isA<PropertyAvailableDate>()],
  // );
}
