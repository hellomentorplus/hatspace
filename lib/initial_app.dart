import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_event.dart';
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
        create: (context) => AuthenticationBloc(),
      ),
      BlocProvider<SignUpBloc>(create: (context) {
        return SignUpBloc()..add(const CheckFirstLaunchSignUp());
      }),
      // TODO add your bloc creation here
    ], child: const MyAppBody());
  }
}

class MyAppBody extends StatelessWidget {
  const MyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      home: BlocListener<SignUpBloc, SignUpState>(
          // Listen when FirstLauch will be navigate to Home Screen.
          listener: (context, state) {
            if (state is FirstLaunchScreen && state.isFirstLaunch == true) {
              context.goToSignup();
            }
          },
          // Always initialise HomePageView
          child: const HomePageView()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        HatSpaceStrings.delegate
      ],
      supportedLocales: HatSpaceStrings.delegate.supportedLocales,
    );
  }
}
