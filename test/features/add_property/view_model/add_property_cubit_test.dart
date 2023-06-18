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
    "Given when user press NEXT button when it's enable, then update new state",
    build: () => AddPropertyCubit(),
    act: (bloc) => {bloc.navigatePage(NavigatePage.forward, 2)},
    expect: () => [isA<PageViewNavigationState>()],
  );

  blocTest(
    "Given when user press BACK button when it's enable, then update new state",
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.navigatePage(NavigatePage.forward, 2);
      bloc.enableNextButton();
      bloc.validateState(0);
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
    "Given when user enable next button, then update new state",
    build: () => AddPropertyCubit(),
    act: (bloc) => {bloc.enableNextButton()},
    expect: () => [isA<NextButtonEnable>()],
  );

  blocTest(
    'Given when validate next button state true, then emit NextButton true',
    build: () => AddPropertyCubit(),
    act: (bloc) {
      bloc.enableNextButton();
      bloc.validateState(0);
    },
    expect: () => [isA<NextButtonEnable>()],
  );

  // blocTest(
  //   'Given when validate next button state true, then emit NextButton true',
  //   build: () => AddPropertyCubit(),
  //   act: (bloc) {
  //     bloc.closeAddPropertyPage();
  //   },
  //   expect: () => [isA<AddPropertyPageClosedState>()],
  // );

  test("test initial state", () {
    AddPropertyInitial addPropertyInitial = const AddPropertyInitial();
    expect(addPropertyInitial.props.length, 0);
    AddPropertyPageClosedState propertyPageClosedState =
        const AddPropertyPageClosedState(1);
    expect(propertyPageClosedState.props.length, 0);
  });

}
