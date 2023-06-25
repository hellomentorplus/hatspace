import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_features_view.dart'
    as view;
import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('[Add Features screen] Verify UI', (WidgetTester tester) async {
    Widget widget = const view.AddFeaturesView();
    const List<String> features = [
      'Fridge',
      'Washing machine',
      'Swimming pool',
      'Air conditioners',
      'Electric stove',
      'TV',
      'Wifi',
      'Security cameras',
      'Kitchen',
      'Portable fans'
    ];

    await tester.wrapAndPump(widget);
    expect(find.byType(view.AddFeaturesView), findsOneWidget);
    expect(find.text('Which features your place has?'), findsOneWidget);
    final Finder featuresItem = find.ancestor(
        of: find.byType(SvgPicture),
        matching: find.byType(view.FeatureItemView));
    final firstFeat =
        tester.firstWidget<view.FeatureItemView>(featuresItem.first);
    final lastFeat =
        tester.firstWidget<view.FeatureItemView>(featuresItem.last);
    expect(features.contains(firstFeat.feature.displayName), true);
    expect(features.contains(lastFeat.feature.displayName), true);
    expect(featuresItem, findsWidgets);
  });

  testWidgets('[Add Features screen] Verify Interaction',
      (WidgetTester tester) async {
    view.AddFeaturesView widget = const view.AddFeaturesView();

    await tester.wrapAndPump(widget);
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
