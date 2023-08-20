import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_preview_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_preview_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit, AuthenticationService])
void main() {
  initializeDateFormatting();
  HatSpaceStrings.load(const Locale('en'));

  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() => HsSingleton.singleton
      .registerSingleton<AuthenticationService>(authenticationService));

  setUp(() {
    when(addPropertyCubit.state).thenReturn(const AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(
              uid: 'uid',
              displayName: 'home owner',
            )));
  });

  tearDown(() {
    reset(addPropertyCubit);
  });

  testWidgets(
      'Given user has inputted property information.'
      'When user go to Preview screen.'
      'User will see all information they have inputted before.',
      (WidgetTester widgetTester) async {
    when(addPropertyCubit.propertyType).thenReturn(PropertyTypes.house);
    when(addPropertyCubit.propertyName)
        .thenReturn('Single room for rent in Bankstown');
    when(addPropertyCubit.suburb).thenReturn('Gateway, Island');
    when(addPropertyCubit.address).thenReturn('123 Gateway, Island');
    when(addPropertyCubit.australiaState).thenReturn(AustraliaStates.vic);
    when(addPropertyCubit.availableDate).thenReturn(DateTime(2023, 6, 6));
    when(addPropertyCubit.price).thenReturn(30000);
    when(addPropertyCubit.description).thenReturn(
        'This updated cottage has much to offer with:- Polished floorboards in living areas and carpeted bedrooms- New modern kitchen with dishwasher, gas burner stove top and plenty of storage- Dining area- Lounge room- Study/Home office space- 2 Bedrooms- Lovely bathroom- Separate laundry.');
    when(addPropertyCubit.rentPeriod).thenReturn(MinimumRentPeriod.sixMonths);
    when(addPropertyCubit.postalCode).thenReturn(3023);
    when(addPropertyCubit.unitNumber).thenReturn('');
    when(addPropertyCubit.bedrooms).thenReturn(1);
    when(addPropertyCubit.bathrooms).thenReturn(1);
    when(addPropertyCubit.parking).thenReturn(1);
    when(addPropertyCubit.features).thenReturn(Feature.values);
    when(addPropertyCubit.photos)
        .thenReturn(['photo1', 'photo2', 'photo3', 'photo4']);

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<AddPropertyCubit>(
            addPropertyCubit, const AddPropertyPreviewView()));
    // property type
    expect(find.text('House'), findsOneWidget);
    // available date
    expect(
        find.text('Available: 06/06/23', findRichText: true), findsOneWidget);
    // property name
    expect(find.text('Single room for rent in Bankstown'), findsOneWidget);
    // state
    expect(find.text('Victoria'), findsOneWidget);
    // price
    expect(find.text(r'$30,000 pw', findRichText: true), findsOneWidget);
    // description
    expect(
        find.text(
            'This updated cottage has much to offer with:- Polished floorboards in living areas and carpeted bedrooms- New modern kitchen with dishwasher, gas burner stove top and plenty of storage- Dining area- Lounge room- Study/Home office space- 2 Bedrooms- Lovely bathroom- Separate laundry.'),
        findsOneWidget);
    // location label
    expect(find.text('Location'), findsOneWidget);
    // full address
    expect(find.text('123 Gateway, Island, Gateway, Island, Victoria'),
        findsOneWidget);
    // feature label
    expect(find.text('Property features'), findsOneWidget);
    // all features
    for (Feature feat in Feature.values) {
      expect(find.text(feat.displayName), findsOneWidget);
    }

    // check all property photos
    expect(find.containerWithImageFile('photo1'), findsOneWidget);
    // swipe next
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    await widgetTester.pumpAndSettle();
    expect(find.containerWithImageFile('photo2'), findsOneWidget);
    // swipe next
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    await widgetTester.pumpAndSettle();
    expect(find.containerWithImageFile('photo3'), findsOneWidget);
    // swipe next
    await widgetTester.drag(find.byType(PageView), const Offset(-500, 0));
    await widgetTester.pumpAndSettle();
    expect(find.containerWithImageFile('photo4'), findsOneWidget);

    // check home owner display name
    expect(find.text('home owner'), findsOneWidget);
  });
}
