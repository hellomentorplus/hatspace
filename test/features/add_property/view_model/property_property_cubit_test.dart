import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property_type/view_modal/property_type_cubit.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'property_property_cubit_test.mocks.dart';

@GenerateMocks([AddPropertyCubit, PropertyTypeCubit])
void main() {
  final MockPropertyTypeCubit propertyCubit = MockPropertyTypeCubit();
  initializeDateFormatting();
  setUp(() {
    when(propertyCubit.state)
        .thenAnswer((realInvocation) => PropertyTypeInitial());
    when(propertyCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(PropertyTypeInitial()));
  });
  blocTest(
    "Given when user select property type, then emit update AddPropertyState with new property tyep",
    build: () => PropertyTypeCubit(),
    act: (bloc) => {bloc.selectPropertyTypeEvent(1)},
    expect: () => [isA<PropertyTypeSelectedState>()],
  );

  blocTest(
    "Given when user select new date, then emit update PropertyTypes with available date",
    build: () => PropertyTypeCubit(),
    act: (bloc) => {bloc.selectAvailableDate(DateTime.now())},
    expect: () => [isA<PropertyAvailableDate>()],
  );
}
