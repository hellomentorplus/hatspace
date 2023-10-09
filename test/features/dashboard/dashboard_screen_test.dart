import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/application/application_view.dart';
import 'package:hatspace/features/dashboard/dashboard_screen.dart';
import 'package:hatspace/features/dashboard/view_model/add_home_owner_role_cubit.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/features/profile/view/profile_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
import 'package:hatspace/models/photo/photo_service.dart';
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
import 'dashboard_screen_test.mocks.dart';

@GenerateMocks([
  AppConfigBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc,
  DashboardInteractionCubit,
  AddHomeOwnerRoleCubit,
  HsPermissionService,
  MemberService,
  PhotoService,
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
  final MockPhotoService photoService = MockPhotoService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(hsPermissionService);
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);

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

  group('verify interaction - explore item', () {
    testWidgets(
        'given user does not log in and is on dashboard screen'
        'when tap on explore item '
        'then HomePageView is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
      ], widget);

      await widgetTester.tap(find.text('Explore'));
      await widgetTester.pumpAndSettle();

      // login bottom sheet is not displayed
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      expect(find.byType(HomePageView), findsOneWidget);
    });

    testWidgets(
        'given user logged in and is on dashboard screen'
        'when tap on explore item '
        'then HomePageView is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
      ], widget);

      await widgetTester.tap(find.text('Explore'));
      await widgetTester.pumpAndSettle();

      // login bottom sheet is not displayed
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      expect(find.byType(HomePageView), findsOneWidget);
    });
  });

  group('verify interaction - Inspection item', () {
    testWidgets(
        'given user does not log in and is on dashboard screen'
        'when tap on Inspection item '
        'then HsLoginModal is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
      ], widget);

      await widgetTester.tap(find.text('Inspection'));
      await widgetTester.pumpAndSettle();

      // login bottom sheet is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pumpAndSettle();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given user logged in and is on dashboard screen'
        'AND user have roles'
        'when tap on Inspection item '
        'then InspectionView is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(authenticationService.getCurrentUser())
          .thenAnswer((_) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
      const Widget widget = DashboardScreen();
      mockNetworkImagesFor(() async {
        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
        ], widget);

        await widgetTester.tap(find.text('Inspection'));
        await widgetTester.pumpAndSettle();

        // login bottom sheet is not displayed
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
        expect(find.byType(InspectionView), findsOneWidget);
      });
    });
  });

  group('verify interaction - Application item', () {
    testWidgets(
        'given user does not log in and is on dashboard screen'
        'when tap on Application item '
        'then HsLoginModal is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
      ], widget);

      await widgetTester.tap(find.text('Application'));
      await widgetTester.pumpAndSettle();

      // login bottom sheet is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pumpAndSettle();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given user logged in and is on dashboard screen'
        'when tap on Application item '
        'then ApplicationView is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);

      const Widget widget = DashboardScreen();
      mockNetworkImagesFor(() async {
        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
        ], widget);
        await widgetTester.tap(find.text('Application'));
        await widgetTester.pumpAndSettle();

        // login bottom sheet is not displayed
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
        expect(find.byType(ApplicationView), findsOneWidget);
      });
    });
  });

  group('verify interaction - Profile item', () {
    testWidgets(
        'given user does not log in and is on dashboard screen'
        'when tap on Profile item '
        'then HsLoginModal is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => false);

      const Widget widget = DashboardScreen();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
      ], widget);

      // Verify on Explore
      await widgetTester.tap(find.text('Profile'));
      await widgetTester.pumpAndSettle();

      // login bottom sheet is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      // verify tap out
      await widgetTester.tapAt(const Offset(20, 20));
      await widgetTester.pumpAndSettle();
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given user logged in and is on dashboard screen'
        'when tap on profile item '
        'then ProfileView is shown', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);

      const Widget widget = DashboardScreen();
      mockNetworkImagesFor(() async {
        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
        ], widget);

        await widgetTester.tap(find.text('Profile'));
        await widgetTester.pumpAndSettle();

        // login bottom sheet is not displayed
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
        expect(find.byType(ProfileView), findsOneWidget);
      });
    });
  });

  testWidgets('verify UI of HsLoginModal ', (widgetTester) async {
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
    await widgetTester.tap(find.text('Inspection'));
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

  group('verify login modal interaction', () {
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
          find.text('"HATspace" Would Like to Photo Access'), findsOneWidget);
      expect(
          find.text(
              'Please go to Settings and allow photos access for HATspace.'),
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

  group('verify interaction - add property item', () {
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

  group('verify logout flow', () {
    testWidgets(
        'given user is login, when user logout, then dashboard navigate to Explore tab',
        (widgetTester) async {
      // given
      when(authenticationService.isUserLoggedIn).thenReturn(true);
      when(authenticationBloc.state).thenReturn(AuthenticatedState(
          UserDetail(uid: 'uiid', displayName: 'display name')));
      // when
      when(authenticationBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(AnonymousState()));

      // navigate to profile page
      when(interactionCubit.state)
          .thenReturn(const OpenPage(BottomBarItems.profile));

      const Widget widget = DashboardBody();
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<DashboardInteractionCubit>(
          create: (context) => interactionCubit,
        ),
        BlocProvider<AddHomeOwnerRoleCubit>(
          create: (context) => addHomeOwnerRoleCubit,
        )
      ], widget);

      await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.byType(HomePageView), findsOneWidget);

      verify(interactionCubit.onBottomItemTapped(BottomBarItems.explore))
          .called(1);
    });
  });

  group('Inspection Bottom App bar interaction', () {
    testWidgets(
        'Given User Logged In'
        'AND user has not any roles'
        'When user tap on Inspection at Bottom app bar'
        'Then navigate to ChooseRoleScreen', (widgetTester) async {
      when(authenticationService.isUserLoggedIn).thenAnswer((_) => true);
      when(authenticationService.getCurrentUser())
          .thenAnswer((_) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles('uid'))
          .thenAnswer((_) => Future.value([]));
      when(interactionCubit.state)
          .thenAnswer((realInvocation) => RequestRoles());
      when(interactionCubit.stream)
          .thenAnswer((realInvocation) => Stream.value(RequestRoles()));
      const Widget widget = DashboardScreen();
      mockNetworkImagesFor(() async {
        await widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<AppConfigBloc>(
            create: (context) => appConfigBloc,
          ),
          BlocProvider<DashboardInteractionCubit>(
              create: (context) => interactionCubit)
        ], widget);
        expect(find.byType(DashboardBody), findsOneWidget);
        await widgetTester.tap(find.text('Inspection'));
        await widgetTester.pumpAndSettle();
        // Navigate to ChooseRoleScreen
        expect(find.byType(DashboardBody), findsNothing);
        expect(find.text('Choose your role'), findsOneWidget);
      });
    });
  });
}
