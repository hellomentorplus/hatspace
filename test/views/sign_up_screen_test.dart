import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_tester_extension.dart';
import 'sign_up_screen_test.mocks.dart';

@GenerateMocks([SignUpBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const widget = SignUpScreen();
  MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/shared_preferences'),
            (MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });
    when(mockSignUpBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(const FirstLaunchScreen(true));
    });
    when(mockSignUpBloc.state).thenAnswer((realInvocation) {
      return const FirstLaunchScreen(true);
    });
    when(mockSignUpBloc.add(const CloseSignUpScreen()))
        .thenAnswer((realInvocation) {
      return SharedPreferences.setMockInitialValues({'isFirstLaunch': false});
    });
  });
  testWidgets('Check skip icon button', (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    Padding wrapContainer = tester.firstWidget(find.byType(Padding));
    expect(wrapContainer.padding,
        const EdgeInsets.only(left: 0, right: 0, bottom: 0));

    // SKIP button
    expect(
        find.ancestor(
            of: find.text('SKIP'), matching: find.byType(TextOnlyButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Google'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Facebook'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Email'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);
  });

  testWidgets('Skip event - detect first launch app',
      (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    SharedPreferences.setMockInitialValues({});
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text('SKIP'), matching: find.byType(TextOnlyButton)));
    await tester.tap(find.byWidget(skipButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expect(pref.getBool(isFirstLaunchConst), false);
  });
}
