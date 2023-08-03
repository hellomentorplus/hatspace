import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/dashboard/dashboard_screen.dart';
import 'package:hatspace/features/dashboard/view_model/add_home_owner_role_cubit.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
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

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import '../dashboard/dashboard_screen_test.mocks.dart';


@GenerateMocks([
  AppConfigBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc,
  DashboardInteractionCubit,
  AddHomeOwnerRoleCubit,
  HsPermissionService,
  MemberService,
])
void main() {
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockDashboardInteractionCubit interactionCubit =
      MockDashboardInteractionCubit();
  final MockAddHomeOwnerRoleCubit addHomeOwnerRoleCubit =
      MockAddHomeOwnerRoleCubit();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockHsPermissionService hsPermissionService = MockHsPermissionService();
  final MockMemberService memberService = MockMemberService();
  initializeDateFormatting();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(hsPermissionService);
    when(storageService.member).thenReturn(memberService);
  });

  setUp(() {
    when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
    when(appConfigBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(authenticationBloc.state).thenReturn(AuthenticationInitial());
    when(authenticationBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(interactionCubit.state).thenReturn(DashboardInitial());
    when(interactionCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(addHomeOwnerRoleCubit.state).thenReturn(AddHomeOwnerRoleInitial());
    when(addHomeOwnerRoleCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  tearDown(() {
    reset(appConfigBloc);
    reset(authenticationBloc);
    reset(interactionCubit);
    reset(addHomeOwnerRoleCubit);
  });

  testWidgets(
      'Given user has not login, when user taps on BottomAppItems, then show LoginBottomSheetModal',
      (widgetTester) async {
    const Widget widget = DashboardScreen();
    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<AppConfigBloc>(
        create: (context) => appConfigBloc,
      ),
    ], widget);

    when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);
    // Verify on Explore
    await widgetTester.tap(find.text('Explore'));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
    // verify tap out
    await widgetTester.tapAt(const Offset(20, 20));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsNothing);

    //verify tap on Booking
    await widgetTester.tap(find.text('Booking'));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
    // verify tap out
    await widgetTester.tapAt(const Offset(20, 20));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsNothing);

    //verify tap on Message
    await widgetTester.tap(find.text('Message'));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
    // verify tap out
    await widgetTester.tapAt(const Offset(20, 20));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsNothing);

    //verify tap on Profile
    await widgetTester.tap(find.text('Profile'));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
    // verify tap out
    await widgetTester.tapAt(const Offset(20, 20));
    await widgetTester.pumpAndSettle();
    expect(find.byType(HsWarningBottomSheetView), findsNothing);
  });

  testWidgets('verify dashboard view listen to changes on BlocListener',
      (widgetTester) async {
    const Widget widget = DashboardScreen();

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
            BlocListener<DashboardInteractionCubit, DashboardInteractionState>),
        findsOneWidget);
  });

  testWidgets(
      'Given HsModalLogin pop up when user taps on bottom item, then verify UI of modal ',
      (widgetTester) async {
    const Widget widget = DashboardScreen();
    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<AppConfigBloc>(
        create: (context) => appConfigBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      )
    ], widget);

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
      when(interactionCubit.state).thenAnswer(
          (_) => const OpenLoginBottomSheetModal(BottomBarItems.explore));
      when(interactionCubit.stream).thenAnswer((_) => Stream.value(
          const OpenLoginBottomSheetModal(BottomBarItems.explore)));
    });
    testWidgets(
        'Given HsModalLogin pop up displayed'
        'when user tap on cancel button'
        'then dismiss modal', (widgetTester) async {
      const Widget widget = DashboardBody();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);
      await expectLater(find.byType(DashboardBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      Finder closeBtn = find.widgetWithText(SecondaryButton, 'No, later');
      await widgetTester.ensureVisible(closeBtn);
      await widgetTester.tap(closeBtn);
      await widgetTester.pumpAndSettle();
      verify(interactionCubit.onCloseLoginModal()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given HsModalLogin pop up displayed'
        'when user tap on go to sign up button'
        'then dismiss modal, and move to signup', (widgetTester) async {
      const Widget widget = DashboardBody();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);
      await expectLater(find.byType(DashboardBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      Finder goToLoginBtn =
          find.widgetWithText(PrimaryButton, 'Yes, login now');
      await widgetTester.ensureVisible(goToLoginBtn);
      await widgetTester.tap(goToLoginBtn);
      await widgetTester.pumpAndSettle();
      verify(interactionCubit.goToSignUpScreen()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });
  });

  group(
    'Add HomeOwner role',
    () {
      setUp(() {
        when(authenticationBloc.state)
            .thenAnswer((realInvocation) => AuthenticationInitial());
        when(authenticationBloc.stream)
            .thenAnswer((realInvocation) => const Stream.empty());
      });

      testWidgets(
          'given HomeInteractionState is RequestHomeOwnerRole,'
          'when launch Home View'
          'then show Add Homeowner role bottom sheet', (widgetTester) async {
        when(interactionCubit.state).thenReturn(RequestHomeOwnerRole());
        when(interactionCubit.stream).thenAnswer(
            (realInvocation) => Stream.value(RequestHomeOwnerRole()));

        const Widget widget = DashboardBody();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<DashboardInteractionCubit>(
            create: (context) => interactionCubit,
          ),
          BlocProvider<AddHomeOwnerRoleCubit>(
            create: (context) => addHomeOwnerRoleCubit,
          )
        ], widget);

        expect(find.text('Add Homeowner role'), findsNWidgets(2));
        expect(
            find.text(
                'Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?'),
            findsOneWidget);
        expect(find.text('Later'), findsOneWidget);

        expect(find.svgPictureWithAssets(Assets.icons.requestHomeownerRole),
            findsOneWidget);
      });

      testWidgets(
          'given Request homeowner role  is visible,'
          'when AddHomeOwnerRoleState is AddHomeOwnerRoleSucceeded,'
          'then dismiss Request homeowner role bottomsheet',
          (widgetTester) async {
        when(interactionCubit.state).thenReturn(RequestHomeOwnerRole());
        when(interactionCubit.stream).thenAnswer(
            (realInvocation) => Stream.value(RequestHomeOwnerRole()));

        when(addHomeOwnerRoleCubit.state)
            .thenReturn(AddHomeOwnerRoleSucceeded());
        when(addHomeOwnerRoleCubit.stream).thenAnswer(
            (realInvocation) => Stream.value(AddHomeOwnerRoleSucceeded()));

        const Widget widget = DashboardBody();

        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<DashboardInteractionCubit>(
            create: (context) => interactionCubit,
          ),
          BlocProvider<AddHomeOwnerRoleCubit>(
            create: (context) => addHomeOwnerRoleCubit,
          )
        ], widget);

        expect(find.text('Add Homeowner role'), findsNothing);
        expect(
            find.text(
                'Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?'),
            findsNothing);
        expect(find.text('Later'), findsNothing);

        expect(find.svgPictureWithAssets(Assets.icons.requestHomeownerRole),
            findsNothing);
        verify(interactionCubit
                .onBottomItemTapped(BottomBarItems.addingProperty))
            .called(1);
      });
    },
  );

  group('Request Photo permission', () {
    testWidgets(
        'given DashboardInteractionState is PhotoPermissionGranted, '
        'when launch dashboard screen'
        'then no HsWarningBottomSheetView is shown and navigate to another screen',
        (widgetTester) async {
      when(interactionCubit.state).thenReturn(PhotoPermissionGranted());
      when(interactionCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionGranted()));

      const Widget widget = DashboardBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      // no bottom sheet
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      // expect navigate to add property flow -> no dashboard screen
      expect(find.byType(DashboardBody), findsNothing);
    });

    testWidgets(
        'given DashboardInteractionState is PhotoPermissionDenied, '
        'when launch dashboard screen'
        'then no HsWarningBottomSheetView is shown and still on dashboard screen',
        (widgetTester) async {
      when(interactionCubit.state).thenReturn(PhotoPermissionDenied());
      when(interactionCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDenied()));

      const Widget widget = DashboardBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      // no bottom sheet
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      // expect navigate to add property flow -> no dashboard screen
      expect(find.byType(DashboardBody), findsOneWidget);
    });

    testWidgets(
        'given DashboardInteractionState is PhotoPermissionDeniedForever, '
        'when launch dashboard screen'
        'then Goto Setting BottomSheet is shown', (widgetTester) async {
      when(interactionCubit.state).thenReturn(PhotoPermissionDeniedForever());
      when(interactionCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDeniedForever()));

      const Widget widget = DashboardBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      SvgPicture uploadPhoto = widgetTester.widget(find.descendant(
          of: find.byType(HsWarningBottomSheetView),
          matching: find.byType(SvgPicture)));
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName,
          'assets/icons/photo_access.svg');
      expect(
          find.text('"HATSpace" Would Like to Photo Access'), findsOneWidget);
      expect(
          find.text(
              'Please go to Settings and allow photos access for HATSpace.'),
          findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Go to Setting'),
              matching: find.byType(PrimaryButton)),
          findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Cancel'), matching: find.byType(SecondaryButton)),
          findsOneWidget);
    });
  });


  group('Verify navigate to expected screen', () {
    testWidgets('Given user login success after tapping "Booking" section',
        (WidgetTester widgetTester) async {
      when(interactionCubit.state)
          .thenReturn(const OpenPage(BottomBarItems.booking));
      when(interactionCubit.stream).thenAnswer((realInvocation) =>
          Stream.value(const OpenPage(BottomBarItems.booking)));
      const Widget widget = DashboardBody();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);
      expect(find.text('Booking View'), findsOneWidget);
    });

    testWidgets('Given user login success after tapping "Message" section',
        (WidgetTester widgetTester) async {
      when(interactionCubit.state)
          .thenReturn(const OpenPage(BottomBarItems.message));
      when(interactionCubit.stream).thenAnswer((realInvocation) =>
          Stream.value(const OpenPage(BottomBarItems.message)));
      const Widget widget = DashboardBody();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);
      expect(find.text('Message View'), findsOneWidget);
    });
    testWidgets('Given user login success after tapping "Profile" section',
        (WidgetTester widgetTester) async {
      when(interactionCubit.state)
          .thenReturn(const OpenPage(BottomBarItems.profile));
      when(interactionCubit.stream).thenAnswer((realInvocation) =>
          Stream.value(const OpenPage(BottomBarItems.profile)));
      const Widget widget = DashboardBody();
            await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);
         expect(find.text('My account'), findsOneWidget);
  });
  group('verify interaction', () {
    testWidgets(
        'given user logged in and is on dashboard screen and photo permission is granted'
        'when tap on add property item '
        'then permission service should request photo permission and navigate to addProperty screen',
        (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(authenticationService.getCurrentUser())
          .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        )
      ], widget);
      expectLater(find.byType(DashboardScreen), findsOneWidget);

      Finder svgPicture = find.descendant(
        of: find.ancestor(
          of: find.byType(Padding),
          matching: find.byType(InkWell),
        ),
        matching: find.byType(SvgPicture),
      );

      SvgPicture uploadPhoto = widgetTester.widget(svgPicture);
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName, 'assets/icons/add.svg');

      await widgetTester.ensureVisible(svgPicture);
      await widgetTester.tap(svgPicture);
      await widgetTester.pumpAndSettle();

      verify(hsPermissionService.checkPhotoPermission()).called(1);
      // navigate to another screen
      expect(find.byType(DashboardScreen), findsNothing);
    });

    testWidgets(
        'given user logged in and is on dashboard screen and photo permission is denied'
        'when tap on add property item '
        'then permission service should request photo permission and not navigate to addProperty screen',
        (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(authenticationService.getCurrentUser())
          .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.denied));

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        )
      ], widget);
      expectLater(find.byType(DashboardScreen), findsOneWidget);

      Finder svgPicture = find.descendant(
        of: find.ancestor(
          of: find.byType(Padding),
          matching: find.byType(InkWell),
        ),
        matching: find.byType(SvgPicture),
      );

      SvgPicture uploadPhoto = widgetTester.widget(svgPicture);
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName, 'assets/icons/add.svg');

      await widgetTester.ensureVisible(svgPicture);
      await widgetTester.tap(svgPicture);
      await widgetTester.pumpAndSettle();

      verify(hsPermissionService.checkPhotoPermission()).called(1);
      // not navigate to another screen
      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets(
        'given user logged in and is on dashboard screen and photo permission is deniedForever'
        'when tap on add property item '
        'then permission service should request photo permission and show gotoSetting bottom sheet',
        (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(authenticationService.getCurrentUser())
          .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.deniedForever));

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        )
      ], widget);
      expectLater(find.byType(DashboardScreen), findsOneWidget);

      Finder svgPicture = find.descendant(
        of: find.ancestor(
          of: find.byType(Padding),
          matching: find.byType(InkWell),
        ),
        matching: find.byType(SvgPicture),
      );

      SvgPicture uploadPhoto = widgetTester.widget(svgPicture);
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName, 'assets/icons/add.svg');

      await widgetTester.ensureVisible(svgPicture);
      await widgetTester.tap(svgPicture);
      await widgetTester.pumpAndSettle();

      verify(hsPermissionService.checkPhotoPermission()).called(1);
      // not navigate to another screen
      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      // expect UI gotoSetting bottom has been covered on group 'Request photo permission'
    });

    testWidgets(
        'given gotoSetting bottom sheet is displayed, '
        'when tap on go to setting,'
        'then navigate to application setting screen', (widgetTester) async {
      when(interactionCubit.state).thenReturn(PhotoPermissionDeniedForever());
      when(interactionCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDeniedForever()));

      const Widget widget = DashboardBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      // bottom sheet is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      Finder goToSettingBtn = find.ancestor(
          of: find.text('Go to Setting'), matching: find.byType(PrimaryButton));

      await widgetTester.ensureVisible(goToSettingBtn);
      await widgetTester.tap(goToSettingBtn);
      await widgetTester.pumpAndSettle();

      verify(interactionCubit.gotoSetting()).called(1);
      // navigate to setting screen
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given gotoSetting bottom sheet is displayed, '
        'when tap on cancel,'
        'then bottom sheet is closed', (widgetTester) async {
      when(interactionCubit.state).thenReturn(PhotoPermissionDeniedForever());
      when(interactionCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDeniedForever()));

      const Widget widget = DashboardBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      // bottom sheet is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      Finder cancelBtn = find.ancestor(
          of: find.text('Cancel'), matching: find.byType(SecondaryButton));

      await widgetTester.ensureVisible(cancelBtn);
      await widgetTester.tap(cancelBtn);
      await widgetTester.pumpAndSettle();

      verify(interactionCubit.cancelPhotoAccess()).called(1);
      // close bottom sheet
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });
  });
  });
  }