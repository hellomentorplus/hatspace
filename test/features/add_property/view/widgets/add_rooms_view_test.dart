import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_rooms_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'add_rooms_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  testWidgets('verify UI components', (widgetTester) async {
    const Widget widget = AddRoomsView();

    await widgetTester.wrapAndPump(widget);

    expect(
        find.text('How many bedrooms, bathrooms, car spaces?'), findsOneWidget);
    expect(find.text('Bedrooms'), findsOneWidget);
    expect(find.text('Bathrooms'), findsOneWidget);
    expect(find.text('Car spaces'), findsOneWidget);

    // all initial numbers are 0
    expect(find.text('0'), findsNWidgets(3));

    // 3 minus icon
    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/images/decrement.svg')),
        findsNWidgets(3));
    // 3 plus icon
    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/images/increment.svg')),
        findsNWidgets(3));
  });

  testWidgets('validate bedrooms interaction', (widgetTester) async {
    when(addPropertyCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const NextButtonEnable(2, false)));
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const NextButtonEnable(2, false));

    const Widget widget = AddRoomsView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bedrooms')),
            matching: find.byWidgetPredicate((widget) =>
                validateSvgPictureWithAssets(
                    widget, 'assets/images/increment.svg'))),
        findsOneWidget);

    await widgetTester.ensureVisible(find.descendant(
        of: find
            .byWidgetPredicate((widget) => findRowForLabel(widget, 'Bedrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));

    // tap on increase button in widget row of Bedrooms
    await widgetTester.tap(find.descendant(
        of: find
            .byWidgetPredicate((widget) => findRowForLabel(widget, 'Bedrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Bedrooms is now 1
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bedrooms')),
            matching: find.text('1')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.bedrooms = 1).called(1);

    // tap on decrease button in widget row of Bedrooms
    await widgetTester.tap(find.descendant(
        of: find
            .byWidgetPredicate((widget) => findRowForLabel(widget, 'Bedrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/decrement.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Bedrooms is now 0
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bedrooms')),
            matching: find.text('0')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.bedrooms = 0).called(1);
  });

  testWidgets('validate bathrooms interaction', (widgetTester) async {
    when(addPropertyCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const NextButtonEnable(2, false)));
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const NextButtonEnable(2, false));

    const Widget widget = AddRoomsView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bathrooms')),
            matching: find.byWidgetPredicate((widget) =>
                validateSvgPictureWithAssets(
                    widget, 'assets/images/increment.svg'))),
        findsOneWidget);

    await widgetTester.ensureVisible(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Bathrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));

    // tap on increase button in widget row of Bedrooms
    await widgetTester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Bathrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Bathrooms is now 1
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bathrooms')),
            matching: find.text('1')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.bathrooms = 1).called(1);

    // tap on decrease button in widget row of Bathrooms
    await widgetTester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Bathrooms')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/decrement.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Bathrooms is now 0
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Bathrooms')),
            matching: find.text('0')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.bathrooms = 0).called(1);
  });

  testWidgets('validate parking interaction', (widgetTester) async {
    when(addPropertyCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const NextButtonEnable(2, false)));
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const NextButtonEnable(2, false));

    const Widget widget = AddRoomsView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Car spaces')),
            matching: find.byWidgetPredicate((widget) =>
                validateSvgPictureWithAssets(
                    widget, 'assets/images/increment.svg'))),
        findsOneWidget);

    await widgetTester.ensureVisible(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Car spaces')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));

    // tap on increase button in widget row of Parkings
    await widgetTester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Car spaces')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/increment.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Parkings is now 1
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Car spaces')),
            matching: find.text('1')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.parking = 1).called(1);

    // tap on decrease button in widget row of Parkings
    await widgetTester.tap(find.descendant(
        of: find.byWidgetPredicate(
            (widget) => findRowForLabel(widget, 'Car spaces')),
        matching: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(
                widget, 'assets/images/decrement.svg'))));
    await widgetTester.pump();

    // validate that the number in row of Parkings is now 0
    expect(
        find.descendant(
            of: find.byWidgetPredicate(
                (widget) => findRowForLabel(widget, 'Car spaces')),
            matching: find.text('0')),
        findsOneWidget);

    // verify that bloc value is updated
    verify(addPropertyCubit.parking = 0).called(1);
  });
}

bool validateSvgPictureWithAssets(Widget widget, String assetName) {
  if (widget is! SvgPicture) {
    return false;
  }

  final BytesLoader bytesLoader = widget.bytesLoader;
  if (bytesLoader is! SvgAssetLoader) {
    return false;
  }

  if (bytesLoader.assetName != assetName) {
    return false;
  }

  return true;
}

bool findRowForLabel(Widget widget, String label) {
  if (widget is! Padding) {
    return false;
  }

  final Widget? paddingChild = widget.child;

  if (paddingChild == null) {
    return false;
  }

  if (paddingChild is! Row) {
    return false;
  }

  final List<Widget> rowChildren = paddingChild.children;

  if (rowChildren.length != 2) {
    return false;
  }

  final Widget rowFirstChild = rowChildren.first;
  if (rowFirstChild is! Text) {
    return false;
  }

  if (rowFirstChild.data != label) {
    return false;
  }

  return true;
}
