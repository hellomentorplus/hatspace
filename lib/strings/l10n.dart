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

  /// `Continue with Google`
  String get googleSignUp {
    return Intl.message(
      'Continue with Google',
      name: 'googleSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get facebookSignUp {
    return Intl.message(
      'Continue with Facebook',
      name: 'facebookSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Email`
  String get emailSignUp {
    return Intl.message(
      'Continue with Email',
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

  /// `You can be a tenant or homeowner or both`
  String get chooseUserRoleDescription {
    return Intl.message(
      'You can be a tenant or homeowner or both',
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

  /// `{description, select, tenant{You can explore properties, connect directly to homeowners, upload your rental application.} homeowner{You can upload and manage your properties, shortlist potential tenants, track the leasing process.} other{}}`
  String userRoleDescription(Object description) {
    return Intl.select(
      description,
      {
        'tenant':
            'You can explore properties, connect directly to homeowners, upload your rental application.',
        'homeowner':
            'You can upload and manage your properties, shortlist potential tenants, track the leasing process.',
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

  /// `Unable to sign you in at the moment. Please try again later.`
  String get signinErrorToastMessage {
    return Intl.message(
      'Unable to sign you in at the moment. Please try again later.',
      name: 'signinErrorToastMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get signinErrorToastTitle {
    return Intl.message(
      'Login Failed',
      name: 'signinErrorToastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingMessage {
    return Intl.message(
      'Loading...',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `What kind of place?`
  String get whatKindOfPlace {
    return Intl.message(
      'What kind of place?',
      name: 'whatKindOfPlace',
      desc: '',
      args: [],
    );
  }

  /// `Choose kind of your property`
  String get chooseKindOfYourProperty {
    return Intl.message(
      'Choose kind of your property',
      name: 'chooseKindOfYourProperty',
      desc: '',
      args: [],
    );
  }

  /// `Available date`
  String get availableDate {
    return Intl.message(
      'Available date',
      name: 'availableDate',
      desc: '',
      args: [],
    );
  }

  /// `How many bedrooms, bathrooms, car spaces?`
  String get addBedroomViewInstructions {
    return Intl.message(
      'How many bedrooms, bathrooms, car spaces?',
      name: 'addBedroomViewInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Bedrooms`
  String get bedroomText {
    return Intl.message(
      'Bedrooms',
      name: 'bedroomText',
      desc: '',
      args: [],
    );
  }

  /// `Bathrooms`
  String get bathroomText {
    return Intl.message(
      'Bathrooms',
      name: 'bathroomText',
      desc: '',
      args: [],
    );
  }

  /// `Car spaces`
  String get parkingText {
    return Intl.message(
      'Car spaces',
      name: 'parkingText',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Inspection`
  String get inspection {
    return Intl.message(
      'Inspection',
      name: 'inspection',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get application {
    return Intl.message(
      'Application',
      name: 'application',
      desc: '',
      args: [],
    );
  }

  /// `Search rental, location...`
  String get searchHint {
    return Intl.message(
      'Search rental, location...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, zero{No rent period} one{1 Month} other { {count} Months }}`
  String rentPeriod(num count) {
    return Intl.plural(
      count,
      zero: 'No rent period',
      one: '1 Month',
      other: ' $count Months ',
      name: 'rentPeriod',
      desc: '',
      args: [count],
    );
  }

  /// `{ausState, select, vic{Victoria} nsw{New South Wales} qld{Queensland} wa{Western Australia} sa{South Australia} tas{Tasmania} act{Australian Capital Territory} nt{Northern Territory} other{No State Available}}`
  String australiaState(Object ausState) {
    return Intl.select(
      ausState,
      {
        'vic': 'Victoria',
        'nsw': 'New South Wales',
        'qld': 'Queensland',
        'wa': 'Western Australia',
        'sa': 'South Australia',
        'tas': 'Tasmania',
        'act': 'Australian Capital Territory',
        'nt': 'Northern Territory',
        'other': 'No State Available',
      },
      name: 'australiaState',
      desc: '',
      args: [ausState],
    );
  }

  /// `Property name`
  String get propertyName {
    return Intl.message(
      'Property name',
      name: 'propertyName',
      desc: '',
      args: [],
    );
  }

  /// `Enter property name`
  String get enterPropertyName {
    return Intl.message(
      'Enter property name',
      name: 'enterPropertyName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Enter your price`
  String get enterYourPrice {
    return Intl.message(
      'Enter your price',
      name: 'enterYourPrice',
      desc: '',
      args: [],
    );
  }

  /// `Minimum rent period`
  String get minimumRentPeriod {
    return Intl.message(
      'Minimum rent period',
      name: 'minimumRentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Enter description`
  String get enterYourDescription {
    return Intl.message(
      'Enter description',
      name: 'enterYourDescription',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Unit number`
  String get unitNumber {
    return Intl.message(
      'Unit number',
      name: 'unitNumber',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Enter unit number`
  String get enterYourUnitnumber {
    return Intl.message(
      'Enter unit number',
      name: 'enterYourUnitnumber',
      desc: '',
      args: [],
    );
  }

  /// `Street address`
  String get streetAddress {
    return Intl.message(
      'Street address',
      name: 'streetAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter street address`
  String get enterStreetAddress {
    return Intl.message(
      'Enter street address',
      name: 'enterStreetAddress',
      desc: '',
      args: [],
    );
  }

  /// `House number + Street name`
  String get houseNumberAndStreetName {
    return Intl.message(
      'House number + Street name',
      name: 'houseNumberAndStreetName',
      desc: '',
      args: [],
    );
  }

  /// `Suburb`
  String get suburb {
    return Intl.message(
      'Suburb',
      name: 'suburb',
      desc: '',
      args: [],
    );
  }

  /// `Enter suburb`
  String get enterYourSuburb {
    return Intl.message(
      'Enter suburb',
      name: 'enterYourSuburb',
      desc: '',
      args: [],
    );
  }

  /// `Postcode`
  String get postcode {
    return Intl.message(
      'Postcode',
      name: 'postcode',
      desc: '',
      args: [],
    );
  }

  /// `Enter postcode`
  String get enterYourPostcode {
    return Intl.message(
      'Enter postcode',
      name: 'enterYourPostcode',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Your address`
  String get yourAddress {
    return Intl.message(
      'Your address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Placeholder`
  String get pleaseEnterYourPlaceholder {
    return Intl.message(
      'Please Enter Your Placeholder',
      name: 'pleaseEnterYourPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `👋 Hi there`
  String get welcomeDefault {
    return Intl.message(
      '👋 Hi there',
      name: 'welcomeDefault',
      desc: '',
      args: [],
    );
  }

  /// `👋 Hi {name}`
  String welcomeName(Object name) {
    return Intl.message(
      '👋 Hi $name',
      name: 'welcomeName',
      desc: '',
      args: [name],
    );
  }

  /// `Pleas select your state`
  String get pleaseSelectYourState {
    return Intl.message(
      'Pleas select your state',
      name: 'pleaseSelectYourState',
      desc: '',
      args: [],
    );
  }

  /// `Please select rent period`
  String get pleaseSelectRentPeriod {
    return Intl.message(
      'Please select rent period',
      name: 'pleaseSelectRentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Please select value`
  String get pleaseSelectValue {
    return Intl.message(
      'Please select value',
      name: 'pleaseSelectValue',
      desc: '',
      args: [],
    );
  }

  /// `Let's add some photos of your place`
  String get letAddSomePhotosOfYourPlace {
    return Intl.message(
      'Let\'s add some photos of your place',
      name: 'letAddSomePhotosOfYourPlace',
      desc: '',
      args: [],
    );
  }

  /// `Require at least 4 photos *`
  String get requireAtLeast4Photos {
    return Intl.message(
      'Require at least 4 photos *',
      name: 'requireAtLeast4Photos',
      desc: '',
      args: [],
    );
  }

  /// `Fridge`
  String get fridge {
    return Intl.message(
      'Fridge',
      name: 'fridge',
      desc: '',
      args: [],
    );
  }

  /// `Washing machine`
  String get washingMachine {
    return Intl.message(
      'Washing machine',
      name: 'washingMachine',
      desc: '',
      args: [],
    );
  }

  /// `Swimming pool`
  String get swimmingPool {
    return Intl.message(
      'Swimming pool',
      name: 'swimmingPool',
      desc: '',
      args: [],
    );
  }

  /// `Air conditioners`
  String get airConditioners {
    return Intl.message(
      'Air conditioners',
      name: 'airConditioners',
      desc: '',
      args: [],
    );
  }

  /// `Electric stove`
  String get electricStove {
    return Intl.message(
      'Electric stove',
      name: 'electricStove',
      desc: '',
      args: [],
    );
  }

  /// `TV`
  String get tv {
    return Intl.message(
      'TV',
      name: 'tv',
      desc: '',
      args: [],
    );
  }

  /// `Wifi`
  String get wifi {
    return Intl.message(
      'Wifi',
      name: 'wifi',
      desc: '',
      args: [],
    );
  }

  /// `Security cameras`
  String get securityCameras {
    return Intl.message(
      'Security cameras',
      name: 'securityCameras',
      desc: '',
      args: [],
    );
  }

  /// `Kitchen`
  String get kitchen {
    return Intl.message(
      'Kitchen',
      name: 'kitchen',
      desc: '',
      args: [],
    );
  }

  /// `Portable Fans`
  String get portableFans {
    return Intl.message(
      'Portable Fans',
      name: 'portableFans',
      desc: '',
      args: [],
    );
  }

  /// `Which features your place has?`
  String get askFeaturesOwned {
    return Intl.message(
      'Which features your place has?',
      name: 'askFeaturesOwned',
      desc: '',
      args: [],
    );
  }

  /// `House`
  String get house {
    return Intl.message(
      'House',
      name: 'house',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `pw`
  String get pw {
    return Intl.message(
      'pw',
      name: 'pw',
      desc: '',
      args: [],
    );
  }

  /// `{number} views today`
  String viewsToday(Object number) {
    return Intl.message(
      '$number views today',
      name: 'viewsToday',
      desc: '',
      args: [number],
    );
  }

  /// `{date}`
  String dateFormatter(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat('MM/dd/yy', Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      '$dateString',
      name: 'dateFormatter',
      desc: '',
      args: [dateString],
    );
  }

  /// `{date}`
  String dateFormatterWithDate(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat('d MMM, y', Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      '$dateString',
      name: 'dateFormatterWithDate',
      desc: '',
      args: [dateString],
    );
  }

  /// `{dateTime}`
  String timeFormatter(DateTime dateTime) {
    final DateFormat dateTimeDateFormat =
        DateFormat('hh:mm a', Intl.getCurrentLocale());
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return Intl.message(
      '$dateTimeString',
      name: 'timeFormatter',
      desc: '',
      args: [dateTimeString],
    );
  }

  /// `{symbol}{currency}`
  String currencyFormatter(String symbol, double currency) {
    final NumberFormat currencyNumberFormat =
        NumberFormat.decimalPattern(Intl.getCurrentLocale());
    final String currencyString = currencyNumberFormat.format(currency);

    return Intl.message(
      '$symbol$currencyString',
      name: 'currencyFormatter',
      desc: '',
      args: [symbol, currencyString],
    );
  }

  /// `Available: `
  String get availableDateColon {
    return Intl.message(
      'Available: ',
      name: 'availableDateColon',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `You need to be logged in to view this content`
  String get loginDescription {
    return Intl.message(
      'You need to be logged in to view this content',
      name: 'loginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Yes, login now`
  String get yesLoginNow {
    return Intl.message(
      'Yes, login now',
      name: 'yesLoginNow',
      desc: '',
      args: [],
    );
  }

  /// `No, later`
  String get noLater {
    return Intl.message(
      'No, later',
      name: 'noLater',
      desc: '',
      args: [],
    );
  }

  /// `Maximum {count} characters`
  String maximumChars(Object count) {
    return Intl.message(
      'Maximum $count characters',
      name: 'maximumChars',
      desc: '',
      args: [count],
    );
  }

  /// `Only accept text`
  String get textWithInvalidChars {
    return Intl.message(
      'Only accept text',
      name: 'textWithInvalidChars',
      desc: '',
      args: [],
    );
  }

  /// `Enter price`
  String get enterPrice {
    return Intl.message(
      'Enter price',
      name: 'enterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Only accept number`
  String get numberFieldContainsNonNumber {
    return Intl.message(
      'Only accept number',
      name: 'numberFieldContainsNonNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter suburb`
  String get enterSuburb {
    return Intl.message(
      'Enter suburb',
      name: 'enterSuburb',
      desc: '',
      args: [],
    );
  }

  /// `Enter postcode`
  String get enterPostalCode {
    return Intl.message(
      'Enter postcode',
      name: 'enterPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `All Photos`
  String get allPhotos {
    return Intl.message(
      'All Photos',
      name: 'allPhotos',
      desc: '',
      args: [],
    );
  }

  /// `"HATspace" Would Like to Photo Access`
  String get hatSpaceWouldLikeToPhotoAccess {
    return Intl.message(
      '"HATspace" Would Like to Photo Access',
      name: 'hatSpaceWouldLikeToPhotoAccess',
      desc: '',
      args: [],
    );
  }

  /// `Please go to Settings and allow photos access for HATspace.`
  String get plsGoToSettingsAndAllowPhotoAccessForHatSpace {
    return Intl.message(
      'Please go to Settings and allow photos access for HATspace.',
      name: 'plsGoToSettingsAndAllowPhotoAccessForHatSpace',
      desc: '',
      args: [],
    );
  }

  /// `Go to Setting`
  String get goToSetting {
    return Intl.message(
      'Go to Setting',
      name: 'goToSetting',
      desc: '',
      args: [],
    );
  }

  /// `Upload {n, plural, =0{({n}) photo} =1{({n}) photo} other{({n}) photos}}`
  String uploadPhotoCount(num n) {
    return Intl.message(
      'Upload ${Intl.plural(n, zero: '($n) photo', one: '($n) photo', other: '($n) photos')}',
      name: 'uploadPhotoCount',
      desc: '',
      args: [n],
    );
  }

  /// `Lost Data`
  String get lostDataTitle {
    return Intl.message(
      'Lost Data',
      name: 'lostDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your data may be lost if you cancel adding new property. Are you sure you want to cancel?`
  String get lostDataDescription {
    return Intl.message(
      'Your data may be lost if you cancel adding new property. Are you sure you want to cancel?',
      name: 'lostDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Preview & Submit`
  String get previewAndSubmit {
    return Intl.message(
      'Preview & Submit',
      name: 'previewAndSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Other information`
  String get otherInformation {
    return Intl.message(
      'Other information',
      name: 'otherInformation',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Favorite lists`
  String get favoriteLists {
    return Intl.message(
      'Favorite lists',
      name: 'favoriteLists',
      desc: '',
      args: [],
    );
  }

  /// `My properties`
  String get myProperties {
    return Intl.message(
      'My properties',
      name: 'myProperties',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get myAccount {
    return Intl.message(
      'My account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `View profile`
  String get viewProfile {
    return Intl.message(
      'View profile',
      name: 'viewProfile',
      desc: '',
      args: [],
    );
  }

  /// `Add Homeowner role`
  String get addHomeOwnerRoleTitle {
    return Intl.message(
      'Add Homeowner role',
      name: 'addHomeOwnerRoleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?`
  String get addHomeOwnerRoleContent {
    return Intl.message(
      'Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?',
      name: 'addHomeOwnerRoleContent',
      desc: '',
      args: [],
    );
  }

  /// `Add Homeowner role`
  String get addHomeOwnerPrimaryBtnLabel {
    return Intl.message(
      'Add Homeowner role',
      name: 'addHomeOwnerPrimaryBtnLabel',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get addHomeOwnerSecondaryBtnLabel {
    return Intl.message(
      'Later',
      name: 'addHomeOwnerSecondaryBtnLabel',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Property features`
  String get propertyFeatures {
    return Intl.message(
      'Property features',
      name: 'propertyFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Cover photo`
  String get coverPhoto {
    return Intl.message(
      'Cover photo',
      name: 'coverPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get displayName {
    return Intl.message(
      'Display name',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Not updated`
  String get notUpdated {
    return Intl.message(
      'Not updated',
      name: 'notUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Guide for application`
  String get guideForApplication {
    return Intl.message(
      'Guide for application',
      name: 'guideForApplication',
      desc: '',
      args: [],
    );
  }

  /// `All adult applicants (18 years or older) must complete a separate application for rental.`
  String get applicationInform {
    return Intl.message(
      'All adult applicants (18 years or older) must complete a separate application for rental.',
      name: 'applicationInform',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the following with your application:`
  String get applicationRequirementsAsking {
    return Intl.message(
      'Please provide the following with your application:',
      name: 'applicationRequirementsAsking',
      desc: '',
      args: [],
    );
  }

  /// `Identification (driver's license/passport)`
  String get applicationIdentification {
    return Intl.message(
      'Identification (driver\'s license/passport)',
      name: 'applicationIdentification',
      desc: '',
      args: [],
    );
  }

  /// `Tenancy ledger/rental reference`
  String get applicationReference {
    return Intl.message(
      'Tenancy ledger/rental reference',
      name: 'applicationReference',
      desc: '',
      args: [],
    );
  }

  /// `Pay slips/centre link statement`
  String get applicationPaySlips {
    return Intl.message(
      'Pay slips/centre link statement',
      name: 'applicationPaySlips',
      desc: '',
      args: [],
    );
  }

  /// `Current bank statement`
  String get applicationBankStatement {
    return Intl.message(
      'Current bank statement',
      name: 'applicationBankStatement',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions, please feel free to let us know. We will always here to support you!`
  String get questionSupport {
    return Intl.message(
      'If you have any questions, please feel free to let us know. We will always here to support you!',
      name: 'questionSupport',
      desc: '',
      args: [],
    );
  }

  /// `Support contact`
  String get contactSupport {
    return Intl.message(
      'Support contact',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message(
      'Send Email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Download Application form here`
  String get downloadApplicationFormHere {
    return Intl.message(
      'Download Application form here',
      name: 'downloadApplicationFormHere',
      desc: '',
      args: [],
    );
  }

  /// `All your data will be kept within 30 days before being deleted permanently. Are you sure you want to delete your account?`
  String get deleteAccountWarning {
    return Intl.message(
      'All your data will be kept within 30 days before being deleted permanently. Are you sure you want to delete your account?',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Delete account?`
  String get deleteAccountQuestionMark {
    return Intl.message(
      'Delete account?',
      name: 'deleteAccountQuestionMark',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get showLess {
    return Intl.message(
      'Show less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get showMore {
    return Intl.message(
      'Show more',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Show more ({counter})`
  String showMoreCounter(Object counter) {
    return Intl.message(
      'Show more ($counter)',
      name: 'showMoreCounter',
      desc: '',
      args: [counter],
    );
  }

  /// `Book Inspection`
  String get bookInspection {
    return Intl.message(
      'Book Inspection',
      name: 'bookInspection',
      desc: '',
      args: [],
    );
  }

  /// `{name} ({symbol})`
  String addPropertyPriceDisplay(Object name, Object symbol) {
    return Intl.message(
      '$name ($symbol)',
      name: 'addPropertyPriceDisplay',
      desc: '',
      args: [name, symbol],
    );
  }

  /// `(PW)`
  String get addPropertyRentalPeriodUnit {
    return Intl.message(
      '(PW)',
      name: 'addPropertyRentalPeriodUnit',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get appleSignUp {
    return Intl.message(
      'Continue with Apple',
      name: 'appleSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Add an inspection booking`
  String get addInspectionBooking {
    return Intl.message(
      'Add an inspection booking',
      name: 'addInspectionBooking',
      desc: '',
      args: [],
    );
  }

  /// `Start time`
  String get startTime {
    return Intl.message(
      'Start time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get endTime {
    return Intl.message(
      'End time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Write a message to homeowner`
  String get notesPlaceHolder {
    return Intl.message(
      'Write a message to homeowner',
      name: 'notesPlaceHolder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logOutDescription {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logOutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get btnLogOut {
    return Intl.message(
      'Log Out',
      name: 'btnLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Inspection Booking`
  String get inspectionBooking {
    return Intl.message(
      'Inspection Booking',
      name: 'inspectionBooking',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations 🎉`
  String get congratulations {
    return Intl.message(
      'Congratulations 🎉',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Your booking is successfully saved and sent to homeowner. To complete the booking, please wait for the confirmation from homeowner.`
  String get bookingSuccessMessage {
    return Intl.message(
      'Your booking is successfully saved and sent to homeowner. To complete the booking, please wait for the confirmation from homeowner.',
      name: 'bookingSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `🎉 Congratulations!`
  String get bookingInspectionSuccessTitle {
    return Intl.message(
      '🎉 Congratulations!',
      name: 'bookingInspectionSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add to Goolge Calendar`
  String get addToGoolgeCalendar {
    return Intl.message(
      'Add to Goolge Calendar',
      name: 'addToGoolgeCalendar',
      desc: '',
      args: [],
    );
  }

  /// `{number} inspection booking`
  String numberOfInspectionBooking(Object number) {
    return Intl.message(
      '$number inspection booking',
      name: 'numberOfInspectionBooking',
      desc: '',
      args: [number],
    );
  }

  /// `{number, plural, one{1 Booking} other { {number} Bookings}}`
  String numberOfBooking(num number) {
    return Intl.plural(
      number,
      one: '1 Booking',
      other: ' $number Bookings',
      name: 'numberOfBooking',
      desc: '',
      args: [number],
    );
  }

  /// `User{datetime}`
  String defaultUserDisplayName(DateTime datetime) {
    final DateFormat datetimeDateFormat =
        DateFormat('ddMMyyhhmmss', Intl.getCurrentLocale());
    final String datetimeString = datetimeDateFormat.format(datetime);

    return Intl.message(
      'User$datetimeString',
      name: 'defaultUserDisplayName',
      desc: '',
      args: [datetimeString],
    );
  }

  /// `You have successfully added your new property!`
  String get successAddingPropertyMessage {
    return Intl.message(
      'You have successfully added your new property!',
      name: 'successAddingPropertyMessage',
      desc: '',
      args: [],
    );
  }

  /// `No booking`
  String get noBooking {
    return Intl.message(
      'No booking',
      name: 'noBooking',
      desc: '',
      args: [],
    );
  }

  /// `Add Tenant role`
  String get addTenantRoleBottomSheetTitle {
    return Intl.message(
      'Add Tenant role',
      name: 'addTenantRoleBottomSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Only Tenant can use this feature. Would you like to add the role Tenant to the list of roles?`
  String get addTenantRoleBottomSheetDescription {
    return Intl.message(
      'Only Tenant can use this feature. Would you like to add the role Tenant to the list of roles?',
      name: 'addTenantRoleBottomSheetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add Tenant Role`
  String get addTenantRole {
    return Intl.message(
      'Add Tenant Role',
      name: 'addTenantRole',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
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
