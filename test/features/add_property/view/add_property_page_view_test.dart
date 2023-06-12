import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/add_property_view.dart';

import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../widget_tester_extension.dart';
import 'add_property_page_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyBloc = MockAddPropertyCubit();
  initializeDateFormatting();
  setUp(() {
    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());
    when(addPropertyBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AddPropertyInitial()));
  });
  testWidgets('test ui for widget', (widgetTester) async {
    Widget widget = const AddPropertyView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget);
    // expect(find.byType(BlocSelector<AddPropertyBloc, AddPropertyState,PropertyTypes>), findsOneWidget);
    expect(find.byType(BlocProvider<AddPropertyCubit>), findsWidgets);
  });

  testWidgets(
      'given when user press close icon then app shows the bottom modal sheet',
      (widgetTester) async {
    Widget widget = const AddPropertyView();
    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget);
    await widgetTester.tap(find.byType(IconButton));
    await widgetTester.pump();
    expect(find.byKey(const Key("warning_bottom_modal")), findsOneWidget);
  });
}
