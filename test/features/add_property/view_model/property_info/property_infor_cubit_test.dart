import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'property_infor_cubit_test.mocks.dart';

@GenerateMocks([PropertyInforCubit])
void main() {
  final MockPropertyInforCubit mockPropertyInforCubit =
      MockPropertyInforCubit();
  // initializeDateFormatting();
  setUp(() {
    when(mockPropertyInforCubit.state)
        .thenAnswer((realInvocation) => PropertyInforInitial());
    when(mockPropertyInforCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(PropertyInforInitial()));
  });
  blocTest(
    'given user select and save australia state, return will be SaveSelectedState',
    build: () => PropertyInforCubit(),
    act: (bloc) => {bloc.saveSelectedState(AustraliaStates.act)},
    expect: () => [
      isA<StartListenAustraliaStateChange>(),
      isA<SavePropertyInforFields>()
    ],
  );
  blocTest(
    'given user select and save rent period state, return will be SaveRentPriodState',
    build: () => PropertyInforCubit(),
    act: (bloc) =>
        {bloc.saveMinimumRentPeriod(MinimumRentPeriod.eighteenMonths)},
    expect: () =>
        [isA<StartListenRentPeriodChange>(), isA<SavePropertyInforFields>()],
  );

  test('test initial state', () {
    PropertyInforInitial propertyInforInitial = PropertyInforInitial();
    expect(propertyInforInitial.propertyInfo.state, AustraliaStates.invalid);
    expect(propertyInforInitial.propertyInfo.rentPeriod,
        MinimumRentPeriod.invalid);
  });
}
