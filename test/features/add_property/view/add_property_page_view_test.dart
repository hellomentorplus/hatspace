import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/add_property_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../widget_tester_extension.dart';
import 'add_property_page_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  HatSpaceStrings.load(const Locale('en'));
  final MockAddPropertyCubit addPropertyBloc = MockAddPropertyCubit();
  initializeDateFormatting();
  setUp(() {
    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());
    when(addPropertyBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AddPropertyInitial()));
  });
  testWidgets('test ui for widget', (widgetTester) async {
    const Widget widget = AddPropertyView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget);
    // expect(find.byType(BlocSelector<AddPropertyBloc, AddPropertyState,PropertyTypes>), findsOneWidget);
    expect(find.byType(BlocProvider<AddPropertyCubit>), findsWidgets);
  });

  testWidgets(
      'given current page is 3, when back button is pressed, then return to page 2',
      (widgetTester) async {
    final Widget widget = AddPropertyPageBody();

    when(addPropertyBloc.propertyType)
        .thenAnswer((realInvocation) => PropertyTypes.house);
    when(addPropertyBloc.availableDate)
        .thenAnswer((realInvocation) => DateTime.now());
    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) => const NextButtonEnable(3, true));
    when(addPropertyBloc.stream).thenAnswer((realInvocation) => const Stream.empty());

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget);

    final NavigatorState navigator = widgetTester.state(find.byType(Navigator));
    navigator.pop();

    await widgetTester.pump();

    // screen will not be dismissed
    expect(find.byType(AddPropertyPageBody), findsOneWidget);
  });

  testWidgets('given current page is 0, when back button is pressed, then exit',
      (widgetTester) async {
    final Widget widget = AddPropertyPageBody();

    when(addPropertyBloc.state)
        .thenAnswer((realInvocation) => const NextButtonEnable(0, true));
    when(addPropertyBloc.stream).thenAnswer((realInvocation) => const Stream.empty());

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget,
        useRouter: true);

    final NavigatorState navigator = widgetTester.state(find.byType(Navigator));
    navigator.pop();

    await widgetTester.pump();

    // screen will not be dismissed
    expect(find.byType(AddPropertyPageBody), findsNothing);
  });
}
