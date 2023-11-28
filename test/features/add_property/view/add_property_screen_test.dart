import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/add_property_screen.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../widget_tester_extension.dart';
import 'add_property_screen_test.mocks.dart';

@GenerateMocks([
  AddPropertyCubit,
  StorageService,
  AuthenticationService,
  PhotoService,
])
void main() {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();

  final MockAddPropertyCubit addPropertyBloc = MockAddPropertyCubit();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockPhotoService photoService = MockPhotoService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);
  });

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
    when(addPropertyBloc.state).thenAnswer((realInvocation) =>
        const NextButtonEnable(3, true, ButtonLabel.next, true));
    when(addPropertyBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

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

    when(addPropertyBloc.state).thenAnswer((realInvocation) =>
        const NextButtonEnable(0, true, ButtonLabel.next, true));
    when(addPropertyBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget,
        useRouter: true);

    final NavigatorState navigator = widgetTester.state(find.byType(Navigator));
    navigator.pop();

    await widgetTester.pump();

    // screen will not be dismissed
    expect(find.byType(AddPropertyPageBody), findsNothing);
  });

  group('Verify lost warning data', () {
    setUp(() {
      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      when(addPropertyBloc.state)
          .thenAnswer((realInvocation) => const AddPropertyInitial());
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());
    });

    testWidgets(
        'Given user is in add property flow'
        'when user tap on X button icon'
        'then verify lostDataModal', (widgetTester) async {
      Widget addPropertyScreen = AddPropertyPageBody();
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, addPropertyScreen);
      expectLater(find.byType(PopScope), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      Finder closeXButton = find.byType(IconButton);
      expect(closeXButton.first, findsOneWidget);
      await widgetTester.ensureVisible(closeXButton);
      await widgetTester.tap(closeXButton);
      await widgetTester.pumpAndSettle();
      verify(addPropertyBloc.onShowLostDataModal()).called(1);
    });

    testWidgets(
        'Given warning lost data modal displayed'
        'when user taps cancel button'
        'then dismiss modal', (widgetTester) async {
      Widget addPropertyScreen = AddPropertyPageBody();
      when(addPropertyBloc.state)
          .thenAnswer((realInvocation) => const OpenLostDataWarningModal(1));
      when(addPropertyBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const OpenLostDataWarningModal(1)));
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, addPropertyScreen);
      expectLater(find.byType(PopScope), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // Find buttons
      Finder cancelBtn = find.widgetWithText(PrimaryButton, 'No');
      // Verify button interaction
      await widgetTester.tap(cancelBtn);
      await widgetTester.pumpAndSettle();
      verify(addPropertyBloc.onCloseLostDataModal()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given warning lost data modal displayed'
        'when user taps yes button'
        'then dismiss modal', (widgetTester) async {
      Widget addPropertyScreen = AddPropertyPageBody();
      when(addPropertyBloc.state)
          .thenAnswer((realInvocation) => const OpenLostDataWarningModal(1));
      when(addPropertyBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const OpenLostDataWarningModal(1)));
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, addPropertyScreen);
      expectLater(find.byType(PopScope), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // Find button
      Finder yesBtn = find.widgetWithText(SecondaryButton, 'Yes');
      // Verify button interaction
      await widgetTester.tap(yesBtn);
      await widgetTester.pumpAndSettle();
      verify(addPropertyBloc.onResetData()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given user at page 0 and already interacted with screen, when user taps back button, then show lost data modal',
        (widgetTester) async {
      Widget addPropertyScreen = AddPropertyPageBody();
      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, addPropertyScreen);
      expectLater(find.byType(PopScope), findsOneWidget);
      Finder backButton = find.widgetWithText(TextOnlyButton, 'Back');
      await widgetTester.tap(backButton);
      verify(addPropertyBloc.onBackPressed(0)).called(1);
    });
  });

  group('verify next button state', () {
    testWidgets(
        'Given page is choose kind of place, when enter add property screen, then btn next is enabled',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(0, true, ButtonLabel.next, true));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsOneWidget);

      final nextBtnWidget = widgetTester.widget<PrimaryButton>(nextBtn);
      expect(nextBtnWidget.onPressed, isNotNull);
      expect(nextBtnWidget.iconUrl, Assets.icons.chevronRight);
      expect(nextBtnWidget.iconPosition, IconPosition.right);
    });

    testWidgets('Given page is property info, then btn next is enabled',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      // default btn state = true
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(2, true, ButtonLabel.next, true));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      // back to page 1: property info
      final NavigatorState navigator =
          widgetTester.state(find.byType(Navigator));
      navigator.pop();

      await widgetTester.pump();

      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsOneWidget);

      final nextBtnWidget = widgetTester.widget<PrimaryButton>(nextBtn);
      expect(nextBtnWidget.onPressed, isNotNull);
      expect(nextBtnWidget.iconUrl, Assets.icons.chevronRight);
      expect(nextBtnWidget.iconPosition, IconPosition.right);
    });

    testWidgets('Given page is rooms, when rooms > 1, then btn next is enabled',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      // rooms > 1 -> state = true
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(3, true, ButtonLabel.next, true));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      // back to page 2: rooms
      final NavigatorState navigator =
          widgetTester.state(find.byType(Navigator));
      navigator.pop();

      await widgetTester.pump();

      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsOneWidget);

      final nextBtnWidget = widgetTester.widget<PrimaryButton>(nextBtn);
      expect(nextBtnWidget.onPressed, isNotNull);
      expect(nextBtnWidget.iconUrl, Assets.icons.chevronRight);
      expect(nextBtnWidget.iconPosition, IconPosition.right);
    });

    testWidgets(
        'Given page is rooms, when rooms < 1, then btn next is disabled',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      // rooms > 1 -> state = false
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(3, false, ButtonLabel.next, true));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      // back to page 2: rooms
      final NavigatorState navigator =
          widgetTester.state(find.byType(Navigator));
      navigator.pop();

      await widgetTester.pump();

      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsOneWidget);

      final nextBtnWidget = widgetTester.widget<PrimaryButton>(nextBtn);
      expect(nextBtnWidget.onPressed, isNull);
      expect(nextBtnWidget.iconUrl, Assets.icons.chevronRight);
      expect(nextBtnWidget.iconPosition, IconPosition.right);
    });

    testWidgets('Given page is features, then btn next is enabled',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      // default btn state = true
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(4, true, ButtonLabel.next, true));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      // back to page 3: features
      final NavigatorState navigator =
          widgetTester.state(find.byType(Navigator));
      navigator.pop();

      await widgetTester.pump();

      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsOneWidget);

      final nextBtnWidget = widgetTester.widget<PrimaryButton>(nextBtn);
      expect(nextBtnWidget.onPressed, isNotNull);
      expect(nextBtnWidget.iconUrl, Assets.icons.chevronRight);
      expect(nextBtnWidget.iconPosition, IconPosition.right);
    });

    testWidgets('Given page is images, then btn preview and submit is disable',
        (widgetTester) async {
      final Widget widget = AddPropertyPageBody();

      when(addPropertyBloc.propertyType)
          .thenAnswer((realInvocation) => PropertyTypes.house);
      when(addPropertyBloc.availableDate)
          .thenAnswer((realInvocation) => DateTime.now());
      // default btn state = false
      when(addPropertyBloc.state).thenAnswer((realInvocation) =>
          const NextButtonEnable(
              5, false, ButtonLabel.previewAndSubmit, false));
      when(addPropertyBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyBloc, widget);

      // back to page 3: features
      final NavigatorState navigator =
          widgetTester.state(find.byType(Navigator));
      navigator.pop();

      await widgetTester.pump();

      // no btn Next
      Finder nextBtn = find.widgetWithText(PrimaryButton, 'Next');
      expect(nextBtn, findsNothing);

      Finder previewAndSubmitBtn =
          find.widgetWithText(PrimaryButton, 'Preview & Submit');
      expect(previewAndSubmitBtn, findsOneWidget);

      final previewAndSubmitBtnWidget =
          widgetTester.widget<PrimaryButton>(previewAndSubmitBtn);
      expect(previewAndSubmitBtnWidget.onPressed, isNull);
      expect(previewAndSubmitBtnWidget.iconUrl, isNull);
      expect(previewAndSubmitBtnWidget.iconPosition, isNull);
    });
  });

  testWidgets('Success toast', (widgetTester) async {
    // Widget widget = BottomController(pageController: PageController(initialPage: 5), totalPages: 5);
    Widget widget = AddPropertyPageBody();
    when(addPropertyBloc.propertyType)
        .thenAnswer((realInvocation) => PropertyTypes.house);
    when(addPropertyBloc.availableDate)
        .thenAnswer((realInvocation) => DateTime.now());
    when(addPropertyBloc.australiaState).thenReturn(AustraliaStates.act);
    when(addPropertyBloc.rentPeriod).thenReturn(MinimumRentPeriod.nineMonths);
    when(addPropertyBloc.propertyName).thenReturn('PropertyName');
    when(addPropertyBloc.price).thenReturn(12.0);
    when(addPropertyBloc.suburb).thenReturn('suburb');
    when(addPropertyBloc.postalCode).thenReturn('1234');
    when(addPropertyBloc.unitNumber).thenReturn('123');
    when(addPropertyBloc.address).thenReturn('address');
    when(addPropertyBloc.description).thenReturn('aksjdkas');
    when(addPropertyBloc.bedrooms).thenReturn(1);
    when(addPropertyBloc.parking).thenReturn(1);
    when(addPropertyBloc.bathrooms).thenReturn(1);
    when(addPropertyBloc.features).thenReturn([]);
    when(addPropertyBloc.photos).thenReturn([]);
    when(addPropertyBloc.state).thenAnswer((realInvocation) {
      return const SuccessSubmitProperty(5);
    });
    when(addPropertyBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const SuccessSubmitProperty(5)));
    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyBloc, widget,
        infiniteAnimationWidget: true);
    await widgetTester.pump(const Duration(seconds: 3));
    // find Toast message
    expectLater(find.byType(ToastMessageContainer), findsOneWidget);
    expect(find.text('🎉 Congratulations!'), findsOneWidget);
    expect(find.text('You have successfully added your new property!'),
        findsOneWidget);
    // after 3 more second, toast should be dismissed
    await widgetTester.pump(const Duration(seconds: 3));
    expectLater(find.byType(ToastMessageContainer), findsNothing);
  });
}
