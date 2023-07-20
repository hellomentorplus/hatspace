import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/features/home/view/home_view.dart';

import 'package:hatspace/features/home/view/widgets/property_item_view.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import 'home_view_test.mocks.dart';

@GenerateMocks([
  AppConfigBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc,
  PropertyService,
  MemberService,
  GetPropertiesCubit,
  HomeInteractionCubit
])
void main() {
  initializeDateFormatting();
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockPropertyService propertyService = MockPropertyService();
  final MockGetPropertiesCubit getPropertiesCubit = MockGetPropertiesCubit();
  final MockMemberService memberService = MockMemberService();
  final MockHomeInteractionCubit interactionCubit = MockHomeInteractionCubit();
  late final List<BlocProvider<StateStreamableSource<Object?>>>
      requiredHomeBlocs;

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    requiredHomeBlocs = [
      BlocProvider<GetPropertiesCubit>(
        create: (context) => getPropertiesCubit,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<HomeInteractionCubit>(
        create: (context) => interactionCubit,
      ),
      BlocProvider<AppConfigBloc>(
        create: (context) => appConfigBloc,
      ),
    ];
  });

  setUp(() {
    when(appConfigBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AppConfigInitialState()));
    when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
    when(storageService.property).thenReturn(propertyService);
    when(storageService.member).thenReturn(memberService);
  });

  group(
    'user not login',
    () {
      setUp(() {
        when(authenticationBloc.state)
            .thenAnswer((realInvocation) => AnonymousState());
        when(authenticationBloc.stream)
            .thenAnswer((realInvocation) => Stream.value(AnonymousState()));
      });

      tearDown(() {
        reset(authenticationBloc);
        reset(appConfigBloc);
      });

      testWidgets('verify home view listen to changes on BlocListener',
          (widgetTester) async {
        const Widget widget = HomePageView();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          )
        ], widget);

        expect(find.byType(BlocListener<AppConfigBloc, AppConfigState>),
            findsOneWidget);
        expect(
            find.byType(
                BlocListener<HomeInteractionCubit, HomeInteractionState>),
            findsOneWidget);
      });

      testWidgets('verify UI components', (widgetTester) async {
        const Widget widget = HomePageView();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          )
        ], widget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Hi there 👋'), findsOneWidget);
        expect(find.text('Search rental, location...'), findsOneWidget);
        expect(find.byType(BottomAppBar), findsOneWidget);
      });
    },
  );

  group('user login', () {
    setUp(() {
      final UserDetail userDetail =
          UserDetail(uid: 'uid', displayName: 'displayName');
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AuthenticatedState(userDetail));
      when(authenticationBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(AuthenticatedState(userDetail)));
    });

    tearDown(() {
      reset(authenticationBloc);
      reset(appConfigBloc);
    });

    testWidgets('verify UI components', (widgetTester) async {
      const Widget widget = HomePageView();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        )
      ], widget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('👋 Hi displayName'), findsOneWidget);
      expect(find.text('Search rental, location...'), findsOneWidget);
      expect(find.byType(BottomAppBar), findsOneWidget);
    });

    // Verify Login Bottom sheet modal
  });

  // Verify login bottom sheet modal
  group('Verify login bottom sheet modal', () {
    setUp(() {
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AnonymousState());
      when(authenticationBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(AnonymousState()));
    });

    tearDown(() {
      reset(authenticationBloc);
      reset(appConfigBloc);
    });

    testWidgets(
        'Given user has not login, when user taps on BottomAppItems, then show HsWarningModalWith',
        (widgetTester) async {
      const Widget widget = HomePageView();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);

      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);
      // Verify on Explore
      await widgetTester.tap(find.text('Explore'));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);

      //verify tap on Booking
      await widgetTester.tap(find.text('Booking'));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);

      //verify tap on Message
      await widgetTester.tap(find.text('Message'));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);

      //verify tap on Profile
      await widgetTester.tap(find.text('Profile'));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given HsModalLogin pop up when user taps on bottom item, then verify UI of modal ',
        (widgetTester) async {
      const Widget widget = HomePageView();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);

      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);
      // Verify on Explore
      await widgetTester.tap(find.text('Explore'));
      await widgetTester.pump();
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      //verify UI
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('You need to be logged in to view this content'),
          findsOneWidget);
      expect(
          find.svgPictureWithAssets(Assets.images.loginCircle), findsOneWidget);
      expect(
          find.widgetWithText(PrimaryButton, 'Yes, login now'), findsOneWidget);
      expect(find.widgetWithText(SecondaryButton, 'No, later'), findsOneWidget);
    });

    group('verify login modal iteraction', () {
      setUp(() {
        when(getPropertiesCubit.state)
            .thenAnswer((_) => const GetPropertiesInitialState());
        when(getPropertiesCubit.stream)
            .thenAnswer((_) => Stream.value(const GetPropertiesInitialState()));
        when(interactionCubit.state).thenAnswer(
            (_) => const OpenLoginBottomSheetModal(BottomBarItems.explore));
        when(interactionCubit.stream).thenAnswer((_) => Stream.value(
            const OpenLoginBottomSheetModal(BottomBarItems.explore)));
      });
      testWidgets(
          'Given HsModalLogin pop up displayed'
          'when user tap on cancel button'
          'then dismiss modal', (widgetTester) async {
        const Widget widget = HomePageBody();
        await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);
        await expectLater(find.byType(HomePageBody), findsOneWidget);
        expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
        // expect(find.widgetWithText(SecondaryButton, 'No, later'), findsOneWidget);
        Finder closeBtn = find.widgetWithText(SecondaryButton, 'No, later');
        await widgetTester.ensureVisible(closeBtn);
        await widgetTester.tap(closeBtn);
        await widgetTester.pumpAndSettle();
        verify(interactionCubit.onCloseModal()).called(1);
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
      });

      testWidgets(
          'Given HsModalLogin pop up displayed'
          'when user tap on go to sign up button'
          'then dismiss modal, and move to signup', (widgetTester) async {
        const Widget widget = HomePageBody();
        await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);
        await expectLater(find.byType(HomePageBody), findsOneWidget);
        expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
        // expect(find.widgetWithText(SecondaryButton, 'No, later'), findsOneWidget);
        Finder goToLoginBtn =
            find.widgetWithText(PrimaryButton, 'Yes, login now');
        await widgetTester.ensureVisible(goToLoginBtn);
        await widgetTester.tap(goToLoginBtn);
        await widgetTester.pumpAndSettle();
        verify(interactionCubit.goToSignUpScreen()).called(1);
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
      });
    });
  });

  group('Test Add Property button when user is not homeowner', () {
    setUp(() {
      final UserDetail userDetail =
          UserDetail(uid: 'uid', displayName: 'displayName');
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AuthenticatedState(userDetail));
      when(authenticationBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(AuthenticatedState(userDetail)));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesInitialState());
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesInitialState()));
    });

    tearDown(() {
      reset(authenticationBloc);
      reset(appConfigBloc);
    });

    testWidgets(
        'Given user is at homepage, logged in and role is tenant'
        'User taps on Add_Property button on bottom bar navigation'
        'Then show bottom sheet update “Homeowner” role', (widgetTester) async {
      const Widget widget = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);
      await expectLater(find.byType(HomePageBody), findsOneWidget);

      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(memberService.getUserRoles(any))
          .thenAnswer((realInvocation) => Future.value([Roles.tenant]));
      when(interactionCubit.state).thenAnswer((_) => ShowAddRoleModal());
      when(interactionCubit.stream)
          .thenAnswer((_) => Stream.value(ShowAddRoleModal()));

      // Verify tap on add property button
      await widgetTester.tap(find.ancestor(
          of: find.svgPictureWithAssets(Assets.icons.add),
          matching: find.byType(InkWell)));
      await widgetTester.pumpAndSettle();
      verify(
          interactionCubit.onBottomItemTapped(BottomBarItems.addingProperty));
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      //verify UI
      expect(find.text('Add Homeowner role'), findsOneWidget);
      expect(
          find.text(
              'Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?'),
          findsOneWidget);
      expect(find.svgPictureWithAssets(Assets.images.landlordCircle),
          findsOneWidget);
      expect(find.widgetWithText(PrimaryButton, 'Add Homeowner role'),
          findsOneWidget);
      expect(find.widgetWithText(SecondaryButton, 'Later'), findsOneWidget);
    });

    testWidgets(
        'Given bottom sheet update “Homeowner” role displayed'
        'When users tap on button “Later”'
        'Then close bottom sheet update “Homeowner” role',
        (widgetTester) async {
      when(interactionCubit.state).thenAnswer((_) => ShowAddRoleModal());
      when(interactionCubit.stream)
          .thenAnswer((_) => Stream.value(ShowAddRoleModal()));

      const Widget widget = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, widget);
      await expectLater(find.byType(HomePageBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      Finder closeBtn = find.widgetWithText(SecondaryButton, 'Later');
      await widgetTester.ensureVisible(closeBtn);
      await widgetTester.tap(closeBtn);
      await widgetTester.pumpAndSettle();
      verify(interactionCubit.onCloseModal()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given bottom sheet update “Homeowner” role displayed'
        'Then HAT system add role ”Homeowner” for this user'
        'Then navigate user to screen “Choose kind of place”',
        (widgetTester) async {});
  });

  group('[Properties] Property list', () {
    /// Set up other blocs/cubits that don't related to property list
    setUpAll(() {
      when(interactionCubit.stream)
          .thenAnswer((_) => Stream.value(HomeInitial()));
      when(interactionCubit.state).thenReturn(HomeInitial());

      when(authenticationBloc.stream)
          .thenAnswer((_) => Stream.value(AnonymousState()));
      when(authenticationBloc.state).thenReturn(AnonymousState());

      when(appConfigBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const AppConfigInitialState()));
      when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
    });
    testWidgets(
        'Given cubit state is initial'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesInitialState()));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesInitialState());

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is loading'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesFailedState()));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesFailedState());

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is success but does not have data'
        'When user firstly goes to home screen'
        'Then user does not see list of property', (widgetTester) async {
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(const GetPropertiesSucceedState([])));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => const GetPropertiesSucceedState([]));

      const Widget home = HomePageBody();
      await widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home);
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        'Given cubit state is success and have data'
        'When user firstly goes to home screen'
        'Then user will see list of property', (widgetTester) async {
      final List<PropertyItemData> fakeData = [
        PropertyItemData(
            id: 'id',
            photos: const ['1', '2'],
            price: 280.0,
            name: 'name',
            state: 'state',
            type: PropertyTypes.apartment,
            numberOfBedrooms: 1,
            numberOfBathrooms: 1,
            numberOfParkings: 1,
            numberOfViewsToday: 20,
            availableDate: DateTime(2023, 1, 1),
            ownerAvatar: '1',
            ownerName: 'name',
            isFavorited: true,
            currency: Currency.aud),
        PropertyItemData(
            id: 'id 1',
            photos: const ['1', '2'],
            price: 270.0,
            name: 'name 1',
            state: 'state 1',
            type: PropertyTypes.apartment,
            numberOfBedrooms: 1,
            numberOfBathrooms: 1,
            numberOfParkings: 1,
            numberOfViewsToday: 20,
            availableDate: DateTime(2023, 1, 2),
            ownerAvatar: '1',
            ownerName: 'name',
            isFavorited: true,
            currency: Currency.aud),
      ];
      when(getPropertiesCubit.stream)
          .thenAnswer((_) => Stream.value(GetPropertiesSucceedState(fakeData)));
      when(getPropertiesCubit.state)
          .thenAnswer((_) => GetPropertiesSucceedState(fakeData));

      const HomePageBody home = HomePageBody();
      await mockNetworkImagesFor(
          () => widgetTester.multiBlocWrapAndPump(requiredHomeBlocs, home));
      await widgetTester.pumpAndSettle();

      final Finder propertiesListViewFinder = find.byType(ListView);
      expect(propertiesListViewFinder, findsOneWidget);

      final PropertyItemView propertyWidget1 =
          widgetTester.widget(find.byKey(ValueKey(fakeData.first.id)));
      expect(propertyWidget1.property.id, fakeData.first.id);

      await widgetTester.drag(propertiesListViewFinder, const Offset(0, -300));
      await widgetTester.pump();

      final PropertyItemView propertyWidget2 =
          widgetTester.widget(find.byKey(ValueKey(fakeData[1].id)));
      expect(propertyWidget2.property.id, fakeData[1].id);
    });
  });
}
