import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../view/select_property_type_test.mocks.dart';

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
  blocTest
  (
    "Given when user select property type, then emit update AddPropertyState with new property tyep",
    build: () => PropertyTypeCubit(),
    act: (bloc) => {bloc.selectPropertyTypeEvent(1)},
    expect: () => [isA<PropertyTypeSelectedState>()],
  );

  blocTest(
    "Given when user select property type, then emit update AddPropertyState with new property tyep",
    build: () => PropertyTypeCubit(),
    act: (bloc) => {bloc.selectAvailableDate(DateTime.now())},
    expect: () => [isA<PropertyAvailableDate>()],
  );

  // test('test state and event', () {
  //   PropertyTypeSelectedState propertyTypeSelectedState =
  //       PropertyTypeSelectedState(PropertyTypes.house, DateTime(2023));
  //   expect(propertyTypeSelectedState.propertyTypes, PropertyTypes.house);
  // });

  //   testWidgets('verify that SelectPropertyType listent to AddPropertyBloc',
  //     (widgetTester) async {
  //   const Widget widget = SelectPropertyType();

  //   await widgetTester.blocWrapAndPump<AddPropertyBloc>(addPropertyBloc, widget);

  //  // expect(find.byType(BlocSelector<AddPropertyBloc, AddPropertyState,PropertyTypes>), findsOneWidget);
  //   Widget abc = widgetTester.firstWidget(find.byType(BlocSelector<AddPropertyBloc, AddPropertyState,PropertyTypes>));
  //   expect(find.byWidget(widget),findsOneWidget);
  //   GridView gridView = widgetTester.widget(find.byType(GridView));
  //   expect(gridView.padding, const EdgeInsets.only(top: 32));
  //   expect(gridView.gridDelegate, const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15));
  // });
}
