import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/my_profile/view/my_profile_screen.dart';
import 'package:hatspace/features/profile/my_profile/view_model/my_profile_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../widget_tester_extension.dart';
import '../../../add_property/view/widgets/add_rooms_view_test.dart';

import 'my_profile_screen_test.mocks.dart';

@GenerateMocks([MyProfileCubit, AuthenticationService])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockMyProfileCubit myProfileCubit = MockMyProfileCubit();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  const String defaultUserAvatar = 'assets/images/user_default_avatar.svg';
  final MockUserDetail user = MockUserDetail();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  testWidgets('Verify UI', (widgetTester) async {
    when(authenticationService.getCurrentUser())
        .thenAnswer((_) => Future.value(user));

    await widgetTester.blocWrapAndPump<MyProfileCubit>(
        myProfileCubit, const MyProfileScreen());

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);

    expect(find.text('Display name'), findsOneWidget);
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);
    expect(find.text('Date of Birth'), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/images/camera_circle.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/arrow_calendar_left.svg')),
        findsOneWidget);
  });

  testWidgets(
      'Given user have information. '
      'When render UI. '
      'Then all fields will be rendered correctly.', (widgetTester) async {
    when(user.avatar).thenReturn('avatar.jpg');
    when(user.displayName).thenReturn('User name');
    when(user.phone).thenReturn('1111');
    when(user.email).thenReturn('email@gmail.com');
    when(myProfileCubit.stream)
        .thenAnswer((_) => Stream.value(GetUserInformationSucceedState(user)));
    when(myProfileCubit.state)
        .thenAnswer((_) => GetUserInformationSucceedState(user));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<MyProfileCubit>(
            myProfileCubit, const MyProfileBody()));

    expect(find.byType(MyProfileBody), findsOneWidget);

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

    expect(find.text('User name'), findsOneWidget);
    expect(find.text('1111'), findsOneWidget);
    expect(find.text('email@gmail.com'), findsOneWidget);
    expect(find.text('Not updated'), findsNWidgets(2));
  });

  testWidgets(
      'Given user do not have information. '
      'When render UI. '
      'Then all fields will be rendered as Not updated, and default avatar will be rendered.',
      (widgetTester) async {
    when(user.avatar).thenReturn(null);
    when(user.displayName).thenReturn(null);
    when(user.phone).thenReturn(null);
    when(user.email).thenReturn(null);
    when(myProfileCubit.stream)
        .thenAnswer((_) => Stream.value(GetUserInformationSucceedState(user)));
    when(myProfileCubit.state)
        .thenAnswer((_) => GetUserInformationSucceedState(user));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<MyProfileCubit>(
            myProfileCubit, const MyProfileBody()));

    expect(find.byType(MyProfileBody), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, defaultUserAvatar)),
        findsOneWidget);

    expect(find.text('Not updated'), findsNWidgets(5));
  });

  testWidgets(
      'Given user are in My Profile Screen. '
      'When user press on back button on AppBar. '
      'Then user will be navigated out of My Profile Screen.',
      (widgetTester) async {
    when(myProfileCubit.stream)
        .thenAnswer((_) => Stream.value(GetUserInformationSucceedState(user)));
    when(myProfileCubit.state)
        .thenAnswer((_) => GetUserInformationSucceedState(user));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<MyProfileCubit>(
            myProfileCubit, const MyProfileBody()));

    expect(find.byType(MyProfileBody), findsOneWidget);

    final Finder backBtnFinder = find.ancestor(
        of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/arrow_calendar_left.svg')),
        matching: find.byType(IconButton));
    await widgetTester.tap(backBtnFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(MyProfileBody), findsNothing);
  });
}
