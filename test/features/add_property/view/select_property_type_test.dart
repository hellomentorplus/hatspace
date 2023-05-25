import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/select_property_type.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../widget_tester_extension.dart';
import 'select_property_type_test.mocks.dart';

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
  testWidgets('verify that SelectPropertyType listent to AddPropertyBloc',
      (widgetTester) async {
    const Widget widget = SelectPropertyType();

    await widgetTester.blocWrapAndPump<AddPropertyBloc>(
        addPropertyBloc, widget);
    expect(find.byWidget(widget), findsOneWidget);
    GridView gridView = widgetTester.widget(find.byType(GridView));
    expect(gridView.padding, const EdgeInsets.only(top: 32));
    expect(
        gridView.gridDelegate,
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15));
  });
}
