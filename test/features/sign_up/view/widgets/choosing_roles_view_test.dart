import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view/widgets/choosing_roles_view.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'choosing_roles_view_test.mocks.dart';

@GenerateMocks([ChooseRoleCubit])
@GenerateNiceMocks([
  MockSpec<AppConfigBloc>(),
  MockSpec<StorageService>(),
  MockSpec<AuthenticationService>(),
  MockSpec<AuthenticationBloc>(),
])
void main() {
  MockChooseRoleCubit mockChooseRoleViewCubit = MockChooseRoleCubit();
  MockAppConfigBloc mockAppConfigBloc = MockAppConfigBloc();
  MockStorageService mockStorageService = MockStorageService();
  MockAuthenticationService mockAuthenticationService =
      MockAuthenticationService();
  MockAuthenticationBloc mockAuthenticationBloc = MockAuthenticationBloc();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(mockStorageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(mockAuthenticationService);
  });

  testWidgets(
      'Given user was not in choose role screen'
      'When user goes to choose role screen'
      'Then user will see required text, all available role options (un-ticked) and close button',
      (WidgetTester tester) async {
    when(mockChooseRoleViewCubit.state)
        .thenAnswer((realInvocation) => const ChoosingRoleState());
    when(mockChooseRoleViewCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const ChoosingRoleState()));

    await tester.blocWrapAndPump<ChooseRoleCubit>(
        mockChooseRoleViewCubit, const ChoosingRoleViewBody());

    expect(find.text('Choose your role'), findsOneWidget);
    expect(find.text('You can be tenant or homeowner'), findsOneWidget);
    final Finder tenantCardFinder = find.byKey(const ValueKey(Roles.tenant));
    expect(tenantCardFinder, findsOneWidget);
    final Card tenantCardWidget = tester.widget<Card>(
        find.descendant(of: tenantCardFinder, matching: find.byType(Card)));
    expect(tenantCardWidget.color, const Color(0xFFF3F3F3));

    final Finder rolesFinder = find.byType(ListView);
    await tester.drag(rolesFinder, const Offset(0, -200));
    await tester.pumpAndSettle();

    final Finder homeOwnerFinder = find.byKey(const ValueKey(Roles.homeowner));
    final Card homeOwnerCardWidget = tester.widget<Card>(
        find.descendant(of: homeOwnerFinder, matching: find.byType(Card)));
    expect(homeOwnerCardWidget.color, const Color(0xFFF3F3F3));
    expect(homeOwnerFinder, findsOneWidget);
    expect(
        find.ancestor(of: find.byType(Icon), matching: find.byType(IconButton)),
        findsOneWidget);

    final Finder signUpBtnFinder = find.ancestor(
        of: find.text('Sign up'), matching: find.byType(PrimaryButton));
    expect(signUpBtnFinder, findsOneWidget);
    final PrimaryButton signUpBtnWidget = tester.widget(signUpBtnFinder);
    expect(signUpBtnWidget.onPressed, null);
  });

  testWidgets(
      'Given user is in choose role screen'
      'When user tap on close button'
      'Then user will goes to home screen', (WidgetTester tester) async {
    await tester.multiBlocWrapAndPump([
      BlocProvider<ChooseRoleCubit>(
          create: (context) => mockChooseRoleViewCubit),
      BlocProvider<AppConfigBloc>(create: (context) => mockAppConfigBloc),
      BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc),
    ], const ChoosingRoleViewBody());

    final closeBtnFinder = find.byType(IconButton);
    expect(closeBtnFinder, findsOneWidget);
    await tester.tap(closeBtnFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ChoosingRoleViewBody), findsNothing);
  });

  testWidgets(
      'Given user was in Choose Role screen and the first role was selected'
      'When user is on the screen and do nothing'
      'Then the first role will be highlighted as Green color with ticked icon, but not second role and the sign up button was enabled.',
      (WidgetTester tester) async {
    when(mockChooseRoleViewCubit.state).thenAnswer(
        (realInvocation) => const ChoosingRoleState(roles: {Roles.tenant}));
    when(mockChooseRoleViewCubit.stream).thenAnswer((realInvocation) =>
        Stream.value(const ChoosingRoleState(roles: {Roles.tenant})));

    await tester.blocWrapAndPump<ChooseRoleCubit>(
        mockChooseRoleViewCubit, const ChoosingRoleViewBody());

    final Finder tenantFinder = find.byKey(const ValueKey(Roles.tenant));
    expect(tenantFinder, findsOneWidget);
    final Card roleCard = tester
        .widget(find.descendant(of: tenantFinder, matching: find.byType(Card)));
    expect(roleCard.color, const Color(0xffEBFAEF));
    final RoundedRectangleBorder cardShape =
        (roleCard.shape as RoundedRectangleBorder);
    expect(cardShape.side.width, 1.5);
    expect(cardShape.side.color, const Color(0xFF32A854));

    final Finder rolesFinder = find.byType(ListView);
    await tester.drag(rolesFinder, const Offset(0, -200));
    await tester.pumpAndSettle();

    final Finder homeOwnerFinder = find.byKey(const ValueKey(Roles.homeowner));
    expect(homeOwnerFinder, findsOneWidget);
    final Card roleCardHomeOwner = tester.widget(
        find.descendant(of: homeOwnerFinder, matching: find.byType(Card)));
    expect(roleCardHomeOwner.color, const Color(0xFFF3F3F3));
    final RoundedRectangleBorder cardShapeAfter =
        (roleCardHomeOwner.shape as RoundedRectangleBorder);
    expect(cardShapeAfter.side.width, 1.5);
    expect(cardShapeAfter.side.color, Colors.transparent);
  });

  testWidgets(
      'Given user was in Choose Role screen and all roles were selected'
      'When user is on the screen and do nothing'
      'Then all roles will be highlighted as Green color with ticked icon and the sign up button was enabled.',
      (WidgetTester tester) async {
    when(mockChooseRoleViewCubit.state).thenAnswer(
        (realInvocation) => const ChoosingRoleState(roles: {Roles.tenant}));
    when(mockChooseRoleViewCubit.stream).thenAnswer((realInvocation) =>
        Stream.value(const ChoosingRoleState(roles: {Roles.tenant})));

    await tester.blocWrapAndPump<ChooseRoleCubit>(
        mockChooseRoleViewCubit, const ChoosingRoleViewBody());

    final Finder tenantFinder = find.byKey(const ValueKey(Roles.tenant));
    expect(tenantFinder, findsOneWidget);
    final Card roleCard = tester
        .widget(find.descendant(of: tenantFinder, matching: find.byType(Card)));
    expect(roleCard.color, const Color(0xffEBFAEF));
    final RoundedRectangleBorder cardShape =
        (roleCard.shape as RoundedRectangleBorder);
    expect(cardShape.side.width, 1.5);
    expect(cardShape.side.color, const Color(0xFF32A854));

    final Finder rolesFinder = find.byType(ListView);
    await tester.drag(rolesFinder, const Offset(0, -200));
    await tester.pumpAndSettle();

    final Finder homeOwnerFinder = find.byKey(const ValueKey(Roles.homeowner));
    expect(homeOwnerFinder, findsOneWidget);
    final Card roleCardHomeOwner = tester.widget(
        find.descendant(of: homeOwnerFinder, matching: find.byType(Card)));
    expect(roleCardHomeOwner.color, const Color(0xFFF3F3F3));
    final RoundedRectangleBorder cardShapeAfter =
        (roleCardHomeOwner.shape as RoundedRectangleBorder);
    expect(cardShapeAfter.side.width, 1.5);
    expect(cardShapeAfter.side.color, Colors.transparent);
  });

  testWidgets(
      'Given user was in Choose Role screen and have selected first role'
      'When user tap on the sign up button'
      'Then SubmitRoleEvent event will be fired.', (WidgetTester tester) async {
    when(mockChooseRoleViewCubit.stream).thenAnswer(
        (_) => Stream.value(const ChoosingRoleState(roles: {Roles.tenant})));
    when(mockChooseRoleViewCubit.state)
        .thenAnswer((_) => const ChoosingRoleState(roles: {Roles.tenant}));

    await tester.multiBlocWrapAndPump([
      BlocProvider<ChooseRoleCubit>(
          create: (context) => mockChooseRoleViewCubit),
      BlocProvider<AppConfigBloc>(create: (context) => mockAppConfigBloc),
      BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc),
    ], const ChoosingRoleViewBody(), useRouter: true);

    final Finder signUpBtnFinder = find.ancestor(
        of: find.text('Sign up'), matching: find.byType(PrimaryButton));
    expect(signUpBtnFinder, findsOneWidget);
    final PrimaryButton signUpBtnWidget = tester.widget(signUpBtnFinder);
    expect(signUpBtnWidget.onPressed != null, true);

    await tester.tap(signUpBtnFinder);
    await tester.pump();

    verify(mockChooseRoleViewCubit.submitUserRoles()).called(1);
  });

  testWidgets(
      'Given user was in Choose Role screen, have selected roles and pressed on Sign up button '
      'When SubmitRoleSucceedState state was emitted'
      'Then navigate user out of this screen.', (WidgetTester tester) async {
    when(mockChooseRoleViewCubit.stream)
        .thenAnswer((_) => Stream.value(const SubmitRoleSucceedState()));
    when(mockChooseRoleViewCubit.state)
        .thenAnswer((_) => const SubmitRoleSucceedState());

    await tester.multiBlocWrapAndPump([
      BlocProvider<ChooseRoleCubit>(
          create: (context) => mockChooseRoleViewCubit),
      BlocProvider<AppConfigBloc>(create: (context) => mockAppConfigBloc),
      BlocProvider<AuthenticationBloc>(
          create: (context) => mockAuthenticationBloc),
    ], const ChoosingRoleViewBody(), useRouter: true);

    expect(find.byType(ChoosingRoleViewBody), findsNothing);
  });
}
