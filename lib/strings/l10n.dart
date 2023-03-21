// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class HatSpaceStrings {
  HatSpaceStrings();

  static HatSpaceStrings? _current;

  static HatSpaceStrings get current {
    assert(_current != null,
        'No instance of HatSpaceStrings was loaded. Try to initialize the HatSpaceStrings delegate before accessing HatSpaceStrings.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<HatSpaceStrings> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = HatSpaceStrings();
      HatSpaceStrings._current = instance;

      return instance;
    });
  }

  static HatSpaceStrings of(BuildContext context) {
    final instance = HatSpaceStrings.maybeOf(context);
    assert(instance != null,
        'No instance of HatSpaceStrings present in the widget tree. Did you add HatSpaceStrings.delegate in localizationsDelegates?');
    return instance!;
  }

  static HatSpaceStrings? maybeOf(BuildContext context) {
    return Localizations.of<HatSpaceStrings>(context, HatSpaceStrings);
  }

  /// `HAT Space`
  String get app_name {
    return Intl.message(
      'HAT Space',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get tracking {
    return Intl.message(
      'Tracking',
      name: 'tracking',
      desc: '',
      args: [],
    );
  }

  /// `Inbox`
  String get inbox {
    return Intl.message(
      'Inbox',
      name: 'inbox',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get googleSignUp {
    return Intl.message(
      'Sign up with Google',
      name: 'googleSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Facebook`
  String get facebookSignUp {
    return Intl.message(
      'Sign up with Facebook',
      name: 'facebookSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with email`
  String get emailSignUp {
    return Intl.message(
      'Sign up with email',
      name: 'emailSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Already have account ?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have account ?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Choose your role`
  String get chooseUserRole {
    return Intl.message(
      'Choose your role',
      name: 'chooseUserRole',
      desc: '',
      args: [],
    );
  }

  /// `You can be tenant or homeowner, OR you can be both.`
  String get chooseUserRoleDescription {
    return Intl.message(
      'You can be tenant or homeowner, OR you can be both.',
      name: 'chooseUserRoleDescription',
      desc: '',
      args: [],
    );
  }

  /// `{role,select,tenant{Tenant} homeowner{Homeowner} other{}}`
  String userTitleRoles(Object role) {
    return Intl.select(
      role,
      {
        'tenant': 'Tenant',
        'homeowner': 'Homeowner',
        'other': '',
      },
      name: 'userTitleRoles',
      desc: '',
      args: [role],
    );
  }

  /// `{description, select, tenant{You can start browsing properties, connect directly to home owner/ agencies, upload your rental application.} homeowner{You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process.} other{}}`
  String userRoleDescription(Object description) {
    return Intl.select(
      description,
      {
        'tenant':
            'You can start browsing properties, connect directly to home owner/ agencies, upload your rental application.',
        'homeowner':
            'You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process.',
        'other': '',
      },
      name: 'userRoleDescription',
      desc: '',
      args: [description],
    );
  }

  /// `Continue`
  String get continueBtn {
    return Intl.message(
      'Continue',
      name: 'continueBtn',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelBtn {
    return Intl.message(
      'Cancel',
      name: 'cancelBtn',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePageViewTitle {
    return Intl.message(
      'Home Page',
      name: 'homePageViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Linear progress indicator`
  String get linearProgressIndicator {
    return Intl.message(
      'Linear progress indicator',
      name: 'linearProgressIndicator',
      desc: '',
      args: [],
    );
  }

  /// `Facebook Login Error Message`
  String get facebookSigninErrorMessage {
    return Intl.message(
      'Facebook Login Error Message',
      name: 'facebookSigninErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Facebook Login Title`
  String get facebookSigninErrorTitle {
    return Intl.message(
      'Facebook Login Title',
      name: 'facebookSigninErrorTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<HatSpaceStrings> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<HatSpaceStrings> load(Locale locale) => HatSpaceStrings.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
