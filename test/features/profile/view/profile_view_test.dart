import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/my_profile/view/my_profile_screen.dart';
import 'package:hatspace/features/profile/view/profile_view.dart';
import 'package:hatspace/features/profile/view_model/profile_cubit.dart';
import 'package:hatspace/features/sign_up/view/sign_up_screen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';
import 'profile_view_test.mocks.dart';

@GenerateMocks([
  ProfileCubit,
  AuthenticationService,
  MemberService,
  StorageService,
])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockProfileCubit profileCubit = MockProfileCubit();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockMemberService memberService = MockMemberService();
  const String defaultUserAvatar = 'assets/images/user_default_avatar.svg';
  final MockUserDetail user = MockUserDetail();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    when(storageService.member).thenReturn(memberService);
  });

  testWidgets('Verify UI', (widgetTester) async {
    await widgetTester.wrapAndPump(const ProfileView());

    // expect(find.text('My account'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // expect(find.text('Favorite lists'), findsOneWidget);
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/favorite.svg')),
    //     findsOneWidget);

    // expect(find.text('Other information'), findsOneWidget);
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/info.svg')),
    //     findsOneWidget);

    // expect(find.text('Language'), findsOneWidget);
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/language.svg')),
    //     findsOneWidget);

    expect(find.text('Log out'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/logout.svg')),
        findsOneWidget);

    expect(find.text('Delete account'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/delete.svg')),
        findsOneWidget);
  });

  testWidgets(
      'when user do not have avatar and name, then the default user avatar will be displayed and display name will be empty',
      (widgetTester) async {
    when(user.avatar).thenReturn(null);
    when(user.displayName).thenReturn(null);
    when(profileCubit.stream).thenAnswer(
        (_) => Stream.value(GetUserDetailSucceedState(user, const [])));
    when(profileCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user, const []));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, defaultUserAvatar)),
        findsOneWidget);
    expect(find.byType(Image), findsNothing);

    expect(find.text(''), findsOneWidget);
  });

  testWidgets(
      'when user have avatar & name, then the user avatar will be displayed instead of default avatar and user name also',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');
    when(profileCubit.stream).thenAnswer(
        (_) => Stream.value(GetUserDetailSucceedState(user, const [])));
    when(profileCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user, const []));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, defaultUserAvatar)),
        findsNothing);

    final Finder avatarFinder = find.byType(Image);
    expect(avatarFinder, findsOneWidget);
    final Image image = widgetTester.widget(avatarFinder);
    final ImageProvider imageProvider = image.image;
    expect(imageProvider, isA<NetworkImage>());
    expect((imageProvider as NetworkImage).url, 'avatar.jpg');

    expect(find.text('This is user name'), findsOneWidget);
  });

  testWidgets('when user have roles, then all user roles will be displayed',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');

    when(profileCubit.stream).thenAnswer((_) => Stream.value(
        GetUserDetailSucceedState(
            user, const [Roles.tenant, Roles.homeowner])));
    when(profileCubit.state).thenAnswer((_) =>
        GetUserDetailSucceedState(user, const [Roles.tenant, Roles.homeowner]));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(find.text(Roles.tenant.title), findsOneWidget);
    expect(find.text(Roles.homeowner.title), findsOneWidget);
  });

  testWidgets('when user does not has roles, then no role was displayed',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');

    when(profileCubit.stream).thenAnswer(
        (_) => Stream.value(GetUserDetailSucceedState(user, const [])));
    when(profileCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user, const []));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(find.text(Roles.tenant.title), findsNothing);
    expect(find.text(Roles.homeowner.title), findsNothing);
  });

  testWidgets('when get user roles failed, then no role was displayed',
      (widgetTester) async {
    when(profileCubit.stream)
        .thenAnswer((_) => Stream.value(const GetUserDetailFailedState()));
    when(profileCubit.state)
        .thenAnswer((_) => const GetUserDetailFailedState());

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(find.text(Roles.tenant.title), findsNothing);
    expect(find.text(Roles.homeowner.title), findsNothing);
  });

  testWidgets(
      'When user tap on user information panel, the app will move user to My Profile Screen',
      (widgetTester) async {
    when(profileCubit.stream)
        .thenAnswer((_) => Stream.value(const ProfileInitialState()));
    when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

    await widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody());

    expect(find.byType(ProfileBody), findsOneWidget);

    final Finder informationPanel = find.ancestor(
        of: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, defaultUserAvatar)),
        matching: find.byType(InkWell));
    expect(informationPanel, findsOneWidget);

    await widgetTester.tap(informationPanel);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ProfileBody), findsNothing);
    expect(find.byType(MyProfileScreen), findsOneWidget);
  });

  testWidgets(
      'Given user tap on Delete Account option and confirmation dialog is showing'
      'When user select Cancel'
      'Then the app will dismiss the dialog', (widgetTester) async {
    when(profileCubit.stream)
        .thenAnswer((_) => Stream.value(const ProfileInitialState()));
    when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

    await widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody());

    expect(find.byType(ProfileBody), findsOneWidget);

    final Finder deleteAccountOptionFinder = find.text('Delete account');
    expect(deleteAccountOptionFinder, findsOneWidget);

    await widgetTester.ensureVisible(deleteAccountOptionFinder);
    await widgetTester.tap(deleteAccountOptionFinder);
    await widgetTester.pumpAndSettle();

    expect(
        find.ancestor(
            of: find.text('Delete account?'),
            matching: find.byType(HsWarningBottomSheetView)),
        findsOneWidget);
    final Finder cancelBtn = find.descendant(
        of: find.byType(HsWarningBottomSheetView),
        matching: find.text('Cancel'));
    expect(cancelBtn, findsOneWidget);
    await widgetTester.tap(cancelBtn);
    await widgetTester.pumpAndSettle();
    expect(
        find.ancestor(
            of: find.text('Delete account?'),
            matching: find.byType(HsWarningBottomSheetView)),
        findsNothing);
  });

  testWidgets(
      'Given user tap on Delete Account option and confirmation dialog is showing'
      'When user select Submit'
      'Then the delete account function was called 1', (widgetTester) async {
    when(profileCubit.stream)
        .thenAnswer((_) => Stream.value(const ProfileInitialState()));
    when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

    await widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody());

    expect(find.byType(ProfileBody), findsOneWidget);

    final Finder deleteAccountOptionFinder = find.text('Delete account');
    expect(deleteAccountOptionFinder, findsOneWidget);

    await widgetTester.ensureVisible(deleteAccountOptionFinder);
    await widgetTester.tap(deleteAccountOptionFinder);
    await widgetTester.pumpAndSettle();

    expect(
        find.ancestor(
            of: find.text('Delete account?'),
            matching: find.byType(HsWarningBottomSheetView)),
        findsOneWidget);
    final Finder submitBtn = find.descendant(
        of: find.byType(HsWarningBottomSheetView),
        matching: find.text('Submit'));
    expect(submitBtn, findsOneWidget);
    await widgetTester.ensureVisible(submitBtn);
    await widgetTester.tap(submitBtn);
    verify(profileCubit.deleteAccount()).called(1);
  });

  testWidgets(
      'Given delete account feature works as expected'
      'When user delete their account'
      'Then the app will navigate user to SignUp Screen', (widgetTester) async {
    when(profileCubit.stream)
        .thenAnswer((_) => Stream.value(const DeleteAccountSucceedState()));
    when(profileCubit.state)
        .thenAnswer((_) => const DeleteAccountSucceedState());
    when(authenticationService.isAppleSignInAvailable).thenReturn(false);
    await widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody());

    expect(
        find.ancestor(
            of: find.text('Delete account?'),
            matching: find.byType(HsWarningBottomSheetView)),
        findsNothing);
    expect(find.byType(ProfileBody), findsNothing);
    expect(find.byType(SignUpScreen), findsOneWidget);
  });

  group('logout bottom sheet', () {
    testWidgets(
        'when user taps on logout item'
        'then the logout bottom sheet is shown', (widgetTester) async {
      when(profileCubit.stream)
          .thenAnswer((_) => Stream.value(const ProfileInitialState()));
      when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

      await widgetTester.blocWrapAndPump<ProfileCubit>(
          profileCubit, const ProfileBody());

      expect(find.byType(ProfileBody), findsOneWidget);

      final Finder logOutFinder = find.text('Log out');
      expect(logOutFinder, findsOneWidget);

      await widgetTester.ensureVisible(logOutFinder);
      await widgetTester.tap(logOutFinder);
      await widgetTester.pumpAndSettle();

      expect(
          find.ancestor(
              of: find.text('Log out'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsOneWidget);
      expect(find.text('Are you sure you want to log out?'), findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Cancel'), matching: find.byType(PrimaryButton)),
          findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Log Out'), matching: find.byType(SecondaryButton)),
          findsOneWidget);
    });

    testWidgets(
        'given LogOut bottom sheet is shown'
        'when user taps on cancel button'
        'then bottom sheet is dismiss and still in profile screen',
        (widgetTester) async {
      when(profileCubit.stream)
          .thenAnswer((_) => Stream.value(const ProfileInitialState()));
      when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

      await widgetTester.blocWrapAndPump<ProfileCubit>(
          profileCubit, const ProfileBody());

      expect(find.byType(ProfileBody), findsOneWidget);

      final Finder logOutFinder = find.text('Log out');
      expect(logOutFinder, findsOneWidget);

      await widgetTester.ensureVisible(logOutFinder);
      await widgetTester.tap(logOutFinder);
      await widgetTester.pumpAndSettle();

      expect(
          find.ancestor(
              of: find.text('Log Out'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsOneWidget);
      final Finder cancelBtn = find.ancestor(
          of: find.text('Cancel'), matching: find.byType(PrimaryButton));
      expect(cancelBtn, findsOneWidget);
      await widgetTester.tap(cancelBtn);
      await widgetTester.pumpAndSettle();
      expect(
          find.ancestor(
              of: find.text('Log Out'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsNothing);
      expect(find.byType(ProfileBody), findsOneWidget);
    });

    testWidgets(
        'given LogOut bottom sheet is shown, '
        'when user taps on log out button, '
        'then bottom sheet is dismiss and call logout', (widgetTester) async {
      when(profileCubit.stream)
          .thenAnswer((_) => Stream.value(const ProfileInitialState()));
      when(profileCubit.state).thenAnswer((_) => const ProfileInitialState());

      await widgetTester.blocWrapAndPump<ProfileCubit>(
          profileCubit, const ProfileBody());

      expect(find.byType(ProfileBody), findsOneWidget);

      final Finder logOutFinder = find.text('Log out');
      expect(logOutFinder, findsOneWidget);

      await widgetTester.ensureVisible(logOutFinder);
      await widgetTester.tap(logOutFinder);
      await widgetTester.pumpAndSettle();

      expect(
          find.ancestor(
              of: find.text('Log Out'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsOneWidget);
      final Finder logOutBtn = find.ancestor(
          of: find.text('Log Out'), matching: find.byType(SecondaryButton));
      expect(logOutBtn, findsOneWidget);
      await widgetTester.tap(logOutBtn);
      await widgetTester.pumpAndSettle();

      // bottom is not displayed
      expect(
          find.ancestor(
              of: find.text('Log Out'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsNothing);
      verify(profileCubit.logOut()).called(1);
    });

    testWidgets(
        'given state is LogOutAccountSucceedState'
        'When launch profile screen'
        'Then the app will navigate user to SignUp Screen',
        (widgetTester) async {
      when(profileCubit.stream)
          .thenAnswer((_) => Stream.value(const LogOutAccountSucceedState()));
      when(profileCubit.state)
          .thenAnswer((_) => const LogOutAccountSucceedState());
      when(authenticationService.isAppleSignInAvailable).thenReturn(false);
      await widgetTester.blocWrapAndPump<ProfileCubit>(
          profileCubit, const ProfileBody());

      expect(find.byType(ProfileBody), findsNothing);
      expect(find.byType(SignUpScreen), findsOneWidget);
    });
  });

  testWidgets(
      'when user only has tenant role, then user will not see My properties option',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');

    when(profileCubit.stream).thenAnswer((_) =>
        Stream.value(GetUserDetailSucceedState(user, const [Roles.tenant])));
    when(profileCubit.state).thenAnswer(
        (_) => GetUserDetailSucceedState(user, const [Roles.tenant]));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(find.text('My properties'), findsNothing);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/apartment.svg')),
        findsNothing);
  });

  testWidgets(
      'when user only has homeowner role, then user will see My properties option',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');

    when(profileCubit.stream).thenAnswer((_) =>
        Stream.value(GetUserDetailSucceedState(user, const [Roles.homeowner])));
    when(profileCubit.state).thenAnswer(
        (_) => GetUserDetailSucceedState(user, const [Roles.homeowner]));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    // expect(find.text('My properties'), findsOneWidget);
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/apartment.svg')),
    //     findsOneWidget);
  });

  testWidgets(
      'when user has both homeowner and tenant role, then user will see My properties option',
      (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('This is user name');

    when(profileCubit.stream).thenAnswer(
        (_) => Stream.value(GetUserDetailSucceedState(user, Roles.values)));
    when(profileCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user, Roles.values));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<ProfileCubit>(
        profileCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    // expect(find.text('My properties'), findsOneWidget);
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/apartment.svg')),
    //     findsOneWidget);
  });
}
