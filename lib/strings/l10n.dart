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

  /// `You can be tenant or homeowner`
  String get chooseUserRoleDescription {
    return Intl.message(
      'You can be tenant or homeowner',
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

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
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

  /// `Enter your address`
  String get enterYourAddress {
    return Intl.message(
      'Enter your address',
      name: 'enterYourAddress',
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

  /// `"HATSpace" Would Like to Photo Access`
  String get hatSpaceWouldLikeToPhotoAccess {
    return Intl.message(
      '"HATSpace" Would Like to Photo Access',
      name: 'hatSpaceWouldLikeToPhotoAccess',
      desc: '',
      args: [],
    );
  }

  /// `Please go to Settings and allow photos access for HATSpace.`
  String get plsGoToSettingsAndAllowPhotoAccessForHatSpace {
    return Intl.message(
      'Please go to Settings and allow photos access for HATSpace.',
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
