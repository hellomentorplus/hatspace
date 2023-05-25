import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'add_property_bloc_test.mocks.dart';

@GenerateMocks([AddPropertyBloc])
void main() {
  final MockAddPropertyBloc addPropertyBloc = MockAddPropertyBloc();
  initializeDateFormatting();
  setUp(() {
    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) => AddPropertyInitial());
    when(addPropertyBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(AddPropertyInitial()));
  });

  blocTest(
    "Given when user select property type, then emit update AddPropertyState with new property tyep",
    build: () => AddPropertyBloc(),
    act: (bloc) => {bloc.add(const SelectPropertyTypeEvent(1))},
    expect: () => [isA<PropertyTypeSelectedState>()],
  );

  blocTest(
    "Given when user select property type, then emit update AddPropertyState with new property tyep",
    build: () => AddPropertyBloc(),
    act: (bloc) => {bloc.add(OnUpdateAvailableEvent(DateTime.now()))},
    expect: () => [isA<PropertyTypeSelectedState>()],
  );

  test('test state and event', () {
    PropertyTypeSelectedState propertyTypeSelectedState =
        PropertyTypeSelectedState(PropertyTypes.house, DateTime(2023));
    expect(propertyTypeSelectedState.propertyTypes, PropertyTypes.house);

    SelectPropertyTypeEvent propertyTypeEvent =
        const SelectPropertyTypeEvent(1);
    expect(propertyTypeEvent.props.length, 1);

    OnUpdateAvailableEvent onUpdateAvailableEvent =
        OnUpdateAvailableEvent(DateTime.now());
    expect(onUpdateAvailableEvent.props.length, 1);
  });

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
