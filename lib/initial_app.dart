import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/dashboard/dashboard_screen.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void listenerEvents(BuildContext context, SignUpState state) {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AppConfigBloc>(create: (context) {
        return AppConfigBloc()..add(const OnInitialRemoteConfig());
      }),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc()..add(OnAppLaunchValidation()),
      ),
      // TODO add your bloc creation here
    ], child: const MyAppBody());
  }
}

class MyAppBody extends StatefulWidget {
  const MyAppBody({super.key});

  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      home: BlocListener<AuthenticationBloc, AuthenticationState>(
          // Listen when FirstLaunch will be navigate to Home Screen.
          listener: (context, state) {
            if (state is RequestSignUp) {
              context.goToSignup();
            }
          },
          // Always initialise HomePageView
          child: const DashboardScreen()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        HatSpaceStrings.delegate
      ],
      supportedLocales: HatSpaceStrings.delegate.supportedLocales,
    );
  }
}
