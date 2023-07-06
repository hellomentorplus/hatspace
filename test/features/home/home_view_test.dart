import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import 'home_view_test.mocks.dart';

@GenerateMocks([
  AppConfigBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc,
])
void main() {
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  setUp(() {
    when(appConfigBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(const AppConfigInitialState()));
    when(appConfigBloc.state).thenReturn(const AppConfigInitialState());
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
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        )
      ], widget);

      when(authenticationService.getIsUserLoggedIn())
          .thenAnswer((_) => Future.value(false));
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
      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AppConfigBloc>(
          create: (context) => appConfigBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        )
      ], widget);

      when(authenticationService.getIsUserLoggedIn())
          .thenAnswer((_) => Future.value(false));
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
  });
}
