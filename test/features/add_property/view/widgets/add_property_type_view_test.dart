import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_type_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_type_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  initializeDateFormatting();

  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUpAll(() {
    withClock(Clock.fixed(DateTime(2022, 10, 15)), () async {
      HsSingleton.singleton.registerSingleton<Clock>(clock);
    });
  });

  setUp(() {
    when(addPropertyCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const AddPropertyInitial()));
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());

    when(addPropertyCubit.availableDate).thenReturn(DateTime(2022, 10, 15));
    when(addPropertyCubit.propertyType).thenReturn(PropertyTypes.house);
  });

  tearDown(() {
    reset(addPropertyCubit);
  });

  testWidgets(
      'given property type and available date are given, when load UI, then show UI with correct data',
      (widgetTester) async {
    when(addPropertyCubit.availableDate).thenReturn(DateTime(2022, 10, 15));
    when(addPropertyCubit.propertyType).thenReturn(PropertyTypes.house);

    const Widget widget = AddPropertyTypeView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    expect(find.text('What kind of place?'), findsOneWidget);
    expect(find.text('Choose kind of your property'), findsOneWidget);

    expect(find.text('House'), findsOneWidget);
    expect(
        find.svgPictureWithAssets('assets/images/house.svg'), findsOneWidget);

    expect(find.text('Apartment'), findsOneWidget);
    expect(find.svgPictureWithAssets('assets/images/apartment.svg'),
        findsOneWidget);

    expect(find.text('Available date'), findsOneWidget);
    expect(find.text('15 October, 2022'), findsOneWidget);

    final Card houseCard = widgetTester.widget(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/house.svg'),
            matching: find.byType(Card))));

    expect(houseCard.color, const Color(0xffEBFAEF));
    expect(houseCard.shape, isA<RoundedRectangleBorder>());

    final RoundedRectangleBorder border =
        houseCard.shape as RoundedRectangleBorder;
    expect(border.borderRadius, BorderRadius.circular(8.0));
    expect(border.side.color, const Color(0xFF32A854));
  });

  testWidgets('verify interaction on apartment type card',
      (widgetTester) async {
    const Widget widget = AddPropertyTypeView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    await widgetTester.ensureVisible(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/apartment.svg'),
            matching: find.byType(InkWell))));

    await widgetTester.tap(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/apartment.svg'),
            matching: find.byType(InkWell))));
    await widgetTester.pump();

    verify(addPropertyCubit.propertyType = PropertyTypes.apartment);
  });

  testWidgets('verify interaction on house type card', (widgetTester) async {
    when(addPropertyCubit.propertyType).thenReturn(PropertyTypes.apartment);

    const Widget widget = AddPropertyTypeView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    await widgetTester.ensureVisible(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/house.svg'),
            matching: find.byType(InkWell))));

    await widgetTester.tap(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/house.svg'),
            matching: find.byType(InkWell))));
    await widgetTester.pump();

    verify(addPropertyCubit.propertyType = PropertyTypes.house);
  });

  testWidgets(
      'verify that the same property type will not trigger cubit change',
      (widgetTester) async {
    when(addPropertyCubit.propertyType).thenReturn(PropertyTypes.apartment);

    const Widget widget = AddPropertyTypeView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    await widgetTester.ensureVisible(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/apartment.svg'),
            matching: find.byType(InkWell))));

    await widgetTester.tap(find.descendant(
        of: find.byType(AspectRatio),
        matching: find.ancestor(
            of: find.svgPictureWithAssets('assets/images/apartment.svg'),
            matching: find.byType(InkWell))));
    await widgetTester.pump();

    verifyNever(addPropertyCubit.propertyType = PropertyTypes.apartment);
    verifyNever(addPropertyCubit.propertyType = PropertyTypes.house);
  });

  testWidgets('when tap on Date, then show HsDatePicker', (widgetTester) async {
    const Widget widget = AddPropertyTypeView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    await widgetTester.tap(find.text('15 October, 2022'));
    await widgetTester.pump();

    expect(find.byType(HsDatePicker), findsOneWidget);

    // when select a date after this date, then update date
    await widgetTester.tap(find.text('16'));
    await widgetTester.pump();

    expect(find.text('16 October, 2022'), findsOneWidget);

    // when select a date before this date, then do not update
    await widgetTester.tap(find.text('14'));
    await widgetTester.pump();

    expect(find.text('16 October, 2022'), findsOneWidget);
    expect(find.text('14 October, 2022'), findsNothing);
  });
}
