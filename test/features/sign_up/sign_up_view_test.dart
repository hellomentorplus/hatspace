import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../widget_tester_extension.dart';
import 'sign_up_view_test.mocks.dart';

@GenerateMocks([SignUpBloc])
void main() {
  final MockSignUpBloc signUpBloc = MockSignUpBloc();

  setUp(() {
    when(signUpBloc.state)
        .thenAnswer((realInvocation) => const SignUpInitial());
    when(signUpBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(const SignUpInitial()));
  });

  testWidgets('verify that SignUpView listen to changes from SignUpBloc',
      (widgetTester) async {
    const Widget widget = SignUpScreen();

    await widgetTester.blocWrapAndPump<SignUpBloc>(signUpBloc, widget);

    expect(find.byType(BlocListener<SignUpBloc, SignUpState>), findsOneWidget);
  });

  testWidgets('verify UI components', (widgetTester) async {
    const Widget widget = SignUpScreen();

    await widgetTester.blocWrapAndPump<SignUpBloc>(signUpBloc, widget);

    expect(find.byType(AppBar), findsOneWidget);

    AppBar appBar = widgetTester.widget(find.byType(AppBar));
    // new design uses white as background color
    expect(appBar.backgroundColor, const Color(0xffffffff));

    expect(
        find.descendant(
            of: find.byType(AppBar), matching: find.byType(SvgPicture)),
        findsOneWidget);
    SvgPicture svgPicture = widgetTester.widget(find.descendant(
        of: find.byType(AppBar), matching: find.byType(SvgPicture)));
    expect(svgPicture.bytesLoader, isA<SvgAssetLoader>());
    SvgAssetLoader assetPicture = svgPicture.bytesLoader as SvgAssetLoader;
    expect(assetPicture.assetName, 'assets/images/close_icon.svg');

    expect(find.widgetWithText(SecondaryButton, 'Sign up with Google'),
        findsOneWidget);
    expect(find.widgetWithText(SecondaryButton, 'Sign up with Facebook'),
        findsOneWidget);
    expect(find.widgetWithText(SecondaryButton, 'Sign up with email'),
        findsOneWidget);
    expect(find.widgetWithText(TextOnlyButton, 'Skip'), findsOneWidget);
  });

  testWidgets("Verify button interaction", (WidgetTester widgetTester) async {
    const Widget widget = SignUpScreen();
    await widgetTester.blocWrapAndPump<SignUpBloc>(signUpBloc, widget);
    // Test interaction with google Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, "Sign up with Google"));
    await widgetTester.pumpAndSettle();
    verify(signUpBloc.add(const SignUpWithGoogle()));
    // Test interaction with facebook Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, "Sign up with Facebook"));
    await widgetTester.pumpAndSettle();
    verify(signUpBloc.add(const SignUpWithFacebook()));
  });
}
