import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_infor_cubit.dart';
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
        .thenAnswer((realInvocation) => const PropertyInforInitial());
    when(mockPropertyInforCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const PropertyInforInitial()));
  });
  blocTest(
    "given user select and save australia state, return will be SaveSelectedState",
    build: () => PropertyInforCubit(),
    act: (bloc) => {bloc.saveSelectedState(AustraliaStates.act)},
    expect: () => [isA<SaveSelectedState>()],
  );
  blocTest(
    "given user select and save rent period state, return will be SaveRentPriodState",
    build: () => PropertyInforCubit(),
    act: (bloc) =>
        {bloc.saveMinimumRentPeriod(MinimumRentPeriod.eighteenMonths)},
    expect: () => [isA<SaveMinimumPeriodState>()],
  );

  test("test initial state", () {
    PropertyInforInitial propertyInforInitial = const PropertyInforInitial();
    expect(propertyInforInitial.savedState, AustraliaStates.invalid);
    expect(propertyInforInitial.saveRentPeriod, MinimumRentPeriod.invalid);
  });
}
