import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/features/home/view/widgets/property_item_view.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';

void main() {
  const PropertyItemData propertyData = PropertyItemData(
    id: 'id',
    availableDate: 'Available',
    bathrooms: 1,
    bedrooms: 2,
    isFavorited: true,
    name: 'property name',
    ownerAvatar: '',
    ownerName: 'Van a',
    parkings: 3,
    photos: ['1', '2', '3'],
    price: '123232',
    todayViews: 20,
    type: PropertyTypes.house,
  );

  testWidgets('Verify PropertyItemView UI', (widgetTester) async {
    const PropertyItemView propertyWidget =
        PropertyItemView(property: propertyData);
    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(ListView(
          children: const [propertyWidget],
        )));
    expect(find.text(propertyData.name), findsOneWidget);
    expect(find.text(propertyData.ownerName), findsOneWidget);
    expect(find.text(propertyData.price), findsOneWidget);
    expect(find.text(propertyData.type.displayName), findsOneWidget);
    expect(
        find.text('Available date: ${propertyData.availableDate}',
            findRichText: true),
        findsOneWidget);
    expect(find.text(propertyData.bathrooms.toString()), findsOneWidget);
    expect(find.text(propertyData.bedrooms.toString()), findsOneWidget);
    expect(find.text(propertyData.parkings.toString()), findsOneWidget);
    expect(find.text('${propertyData.todayViews} views today'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(5));
    expect(find.text('pw'), findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(CircleAvatar), matching: find.byType(NetworkImage)),
        findsOneWidget);
  });

  testWidgets('Verify PropertyItemView photos pageview interaction',
      (widgetTester) async {
    const PropertyItemView propertyWidget =
        PropertyItemView(property: propertyData);
    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(ListView(
          children: const [propertyWidget],
        )));

    final Finder imgsPageViewFinder = find.byType(PageView);
    expect(imgsPageViewFinder, findsOneWidget);
    final PageView pageViewWidget =
        widgetTester.firstWidget<PageView>(imgsPageViewFinder);

    while (true) {
      final Finder imgFinder = find.descendant(
          of: imgsPageViewFinder, matching: find.byType(Container));
      expect(imgFinder, findsOneWidget);

      final String imgUrl = ((widgetTester
                  .firstWidget<Container>(imgFinder)
                  .decoration as BoxDecoration)
              .image!
              .image as NetworkImage)
          .url;
      final int currentPage = pageViewWidget.controller.page!.round();

      /// Compare rendering image's url with data url
      expect(imgUrl == propertyData.photos[currentPage], true);

      await widgetTester.drag(imgsPageViewFinder, const Offset(-800, 0));
      await widgetTester.pumpAndSettle();
      final int newPage = pageViewWidget.controller.page!.toInt();
      if (newPage == currentPage) {
        break;
      }
    }
  });

  testWidgets('Verify PropertyItemView favorite interaction',
      (widgetTester) async {
    const PropertyItemView propertyWidget =
        PropertyItemView(property: propertyData);
    const String activeSvgPath = 'assets/icons/favorite_active.svg';
    const String unActiveSvgPath = 'assets/icons/favorite_active.svg';
    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(ListView(
          children: const [propertyWidget],
        )));

    final Finder favoriteIconFinder = find.descendant(
        of: find.byType(Positioned),
        matching: find.descendant(
            of: find.byType(InkWell), matching: find.byType(SvgPicture)));
    expect(favoriteIconFinder, findsOneWidget);

    final BytesLoader favoriteIconData =
        widgetTester.widget<SvgPicture>(favoriteIconFinder).bytesLoader;
    expect(favoriteIconData, isA<SvgAssetLoader>());
    expect((favoriteIconData as SvgAssetLoader).assetName, activeSvgPath);

    await widgetTester.tap(favoriteIconFinder);
    await widgetTester.pumpAndSettle();

    final Finder updatedFavoriteIconFinder = find.descendant(
        of: find.byType(Positioned),
        matching: find.descendant(
            of: find.byType(InkWell), matching: find.byType(SvgPicture)));
    final BytesLoader updatedFavoriteIconData =
        widgetTester.widget<SvgPicture>(updatedFavoriteIconFinder).bytesLoader;
    expect(updatedFavoriteIconData, isA<SvgAssetLoader>());
    expect(
        (updatedFavoriteIconData as SvgAssetLoader).assetName, unActiveSvgPath);
  });
}
