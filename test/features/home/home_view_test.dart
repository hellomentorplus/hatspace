import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
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
        when(authenticationService.getCurrentUser())
            .thenThrow(UserNotFoundException());
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
          ),
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

      testWidgets('verify login modal when user tap item bottom bar',
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
        // tap any bottom app item will show login modal
        await widgetTester.tap(find.text(HatSpaceStrings.current.explore));
        await widgetTester.pump();
        expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
        // verify all ui component of login modal
        expect(find.widgetWithText(PrimaryButton, 'Yes'), findsOneWidget);
        expect(
            find.widgetWithText(SecondaryButton, 'No, later'), findsOneWidget);

        expect(find.svgPictureWithAssets(Assets.images.loginCircle),
            findsOneWidget);
        expect(find.text('Login'), findsOneWidget);
        expect(find.text('You need to be logged in to view this content'),
            findsOneWidget);

        // verify tap out to close
        await widgetTester.tapAt(const Offset(20.0, 20.0));
        await widgetTester.pump();
        expect(find.byType(HsWarningBottomSheetView), findsNothing);
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
  });
}
