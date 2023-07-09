import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_features_view.dart'
    as view;
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../widget_tester_extension.dart';

import 'add_property_features_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUp(() {
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(addPropertyCubit.state).thenReturn(const AddPropertyInitial());

    when(addPropertyCubit.features).thenReturn([]);
  });

  testWidgets('[Add Features screen] Verify UI', (WidgetTester tester) async {
    bool isReachedBottom = false;
    Widget widget = NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          isReachedBottom = metrics.pixels != 0;
        }
        return true;
      },
      child: const view.AddPropertyFeaturesView(),
    );

    await tester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

    expect(find.byType(view.AddPropertyFeaturesView), findsOneWidget);
    expect(find.text('Which features your place has?'), findsOneWidget);

    const List<Feature> definedFeatures = Feature.values;
    final Set<view.FeatureItemView> foundFeatureWidgets = {};

    foundFeatureWidgets.addAll(tester
        .widgetList<view.FeatureItemView>(find.descendant(
            of: find.byType(GridView),
            matching: find.byType(view.FeatureItemView)))
        .toSet());

    while (!isReachedBottom) {
      final Finder gridViewFinder = find.byType(GridView);
      await tester.drag(gridViewFinder, const Offset(0, -10));
      await tester.pumpAndSettle();
      final Set<view.FeatureItemView> newFeatWidgets = tester
          .widgetList<view.FeatureItemView>(find.descendant(
              of: gridViewFinder, matching: find.byType(view.FeatureItemView)))
          .toSet();
      foundFeatureWidgets.addAll([...foundFeatureWidgets, ...newFeatWidgets]);
    }

    /// Compare length
    expect(definedFeatures.length == foundFeatureWidgets.length, true);

    /// Compare type and order
    for (int i = 0; i < definedFeatures.length; i++) {
      expect(
          definedFeatures[i] == foundFeatureWidgets.elementAt(i).feature, true);
    }
  });

  testWidgets('[Add Features screen] Verify Interaction',
      (WidgetTester tester) async {
    view.AddPropertyFeaturesView widget = const view.AddPropertyFeaturesView();

    await tester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);
    final Finder featuresBtns = find.byType(view.FeatureItemView);
    final firstFeat =
        tester.firstWidget<view.FeatureItemView>(featuresBtns.first);
    final lastFeat =
        tester.firstWidget<view.FeatureItemView>(featuresBtns.last);
    expect(firstFeat.isSelected, false);
    expect(lastFeat.isSelected, false);

    await tester.tap(featuresBtns.first);
    await tester.tap(featuresBtns.last);
    await tester.pumpAndSettle();

    expect(
        tester.firstWidget<view.FeatureItemView>(featuresBtns.first).isSelected,
        true);
    expect(
        tester.firstWidget<view.FeatureItemView>(featuresBtns.last).isSelected,
        true);

    await tester.tap(featuresBtns.first);
    await tester.pumpAndSettle();
    expect(
        tester.firstWidget<view.FeatureItemView>(featuresBtns.first).isSelected,
        false);
    expect(
        tester.firstWidget<view.FeatureItemView>(featuresBtns.last).isSelected,
        true);
  });

  testWidgets('[Feature Item View] Verify UI and Interaction',
      (WidgetTester tester) async {
    final ValueNotifier<bool> isSelected = ValueNotifier<bool>(false);
    Widget widget = ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (_, isSelectedData, __) {
          return view.FeatureItemView(
            feature: Feature.electricStove,
            isSelected: isSelectedData,
            onSelectionChanged: (feature, selected) =>
                isSelected.value = !selected,
          );
        });

    await tester.wrapAndPump(widget);
    expect(find.byType(view.FeatureItemView), findsOneWidget);
    expect(find.text(Feature.electricStove.displayName), findsOneWidget);

    /// Find only 1 svg for icon, not found tick icon
    expect(find.byType(SvgPicture), findsOneWidget);

    /// Verify interaction
    await tester.tap(find.byType(view.FeatureItemView));
    await tester.pumpAndSettle();
    expect(isSelected.value, true);

    /// Found tick icon vs icon
    expect(find.byType(SvgPicture), findsNWidgets(2));

    /// Verify properties
    final view.FeatureItemView item =
        tester.widget(find.byType(view.FeatureItemView));
    expect(item.isSelected, true);

    isSelected.dispose();
  });
}
