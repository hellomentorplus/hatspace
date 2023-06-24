import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/add_features_view.dart'
    as view;
import 'package:hatspace/gen/assets.gen.dart';
import '../../../widget_tester_extension.dart';

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
    expect(features.contains(firstFeat.title), true);
    expect(features.contains(lastFeat.title), true);
    expect(featuresItem, findsWidgets);
  });

  testWidgets('[Add Features screen] Verify Interaction',
      (WidgetTester tester) async {
    view.AddFeaturesView widget = view.AddFeaturesView();

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
    const String title = 'Test title';
    final ValueNotifier<bool> isSelected = ValueNotifier<bool>(false);
    Widget widget = ValueListenableBuilder(
        valueListenable: isSelected,
        builder: (_, isSelectedData, __) {
          return view.FeatureItemView(
            title: title,
            iconSvgPath: Assets.icons.airConditioners,
            isSelected: isSelectedData,
            onSelectionChanged: (feature, selected) =>
                isSelected.value = !selected,
          );
        });

    await tester.wrapAndPump(widget);
    expect(find.byType(view.FeatureItemView), findsOneWidget);
    expect(find.text(title), findsOneWidget);

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
