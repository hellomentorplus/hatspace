import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/profile_screen.dart';
import 'package:hatspace/features/profile/view_model/get_user_detail_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

import '../add_property/view/widgets/add_rooms_view_test.dart';
import 'profile_screen_test.mocks.dart';

@GenerateMocks(
    [GetUserDetailCubit, AuthenticationService, MemberService, StorageService])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockGetUserDetailCubit getUserDetailCubit = MockGetUserDetailCubit();
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
    await widgetTester.wrapAndPump(const ProfileScreen());

    expect(find.text('My account'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    expect(find.text('My properties'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/apartment.svg')),
        findsOneWidget);

    expect(find.text('Favorite lists'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/favorite.svg')),
        findsOneWidget);

    expect(find.text('Other information'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/info.svg')),
        findsOneWidget);

    expect(find.text('Language'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/language.svg')),
        findsOneWidget);

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
    when(getUserDetailCubit.stream)
        .thenAnswer((_) => Stream.value(GetUserDetailSucceedState(user)));
    when(getUserDetailCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetUserDetailCubit>(
            getUserDetailCubit, const ProfileBody()));

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
    when(getUserDetailCubit.stream)
        .thenAnswer((_) => Stream.value(GetUserDetailSucceedState(user)));
    when(getUserDetailCubit.state)
        .thenAnswer((_) => GetUserDetailSucceedState(user));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetUserDetailCubit>(
            getUserDetailCubit, const ProfileBody()));

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
    when(getUserDetailCubit.stream).thenAnswer((_) => Stream.value(
        const GetUserRolesSucceedState([Roles.tenant, Roles.homeowner])));
    when(getUserDetailCubit.state).thenAnswer(
        (_) => const GetUserRolesSucceedState([Roles.tenant, Roles.homeowner]));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<GetUserDetailCubit>(
            getUserDetailCubit, const ProfileBody()));

    expect(find.byType(ProfileBody), findsOneWidget);

    expect(find.text(Roles.tenant.title), findsOneWidget);
    expect(find.text(Roles.homeowner.title), findsOneWidget);
  });

  testWidgets('when user does not has roles, then no role was displayed',
      (widgetTester) async {
    when(getUserDetailCubit.stream)
        .thenAnswer((_) => Stream.value(const GetUserRolesSucceedState([])));
    when(getUserDetailCubit.state)
        .thenAnswer((_) => const GetUserRolesSucceedState([]));

    await _pumpAndVerifyNoRoles(widgetTester, getUserDetailCubit);
  });

  testWidgets('when get user roles failed, then no role was displayed',
      (widgetTester) async {
    when(getUserDetailCubit.stream)
        .thenAnswer((_) => Stream.value(const GetUserRolesFailedState()));
    when(getUserDetailCubit.state)
        .thenAnswer((_) => const GetUserRolesFailedState());

    await _pumpAndVerifyNoRoles(widgetTester, getUserDetailCubit);
  });

  testWidgets('when getting user roles, then no role was displayed',
      (widgetTester) async {
    when(getUserDetailCubit.stream)
        .thenAnswer((_) => Stream.value(const GettingUserRolesState()));
    when(getUserDetailCubit.state)
        .thenAnswer((_) => const GettingUserRolesState());

    await _pumpAndVerifyNoRoles(widgetTester, getUserDetailCubit);
  });
}

Future<void> _pumpAndVerifyNoRoles(
    WidgetTester widgetTester, GetUserDetailCubit getUserDetailCubit) async {
  await mockNetworkImagesFor(() =>
      widgetTester.blocWrapAndPump<GetUserDetailCubit>(
          getUserDetailCubit, const ProfileBody()));

  expect(find.byType(ProfileBody), findsOneWidget);

  expect(find.text(Roles.tenant.title), findsNothing);
  expect(find.text(Roles.homeowner.title), findsNothing);
}
