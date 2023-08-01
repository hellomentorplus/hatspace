// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(ausState) => "${Intl.select(ausState, {
            'vic': 'Victoria',
            'nsw': 'New South Wales',
            'qld': 'Queensland',
            'wa': 'Western Australia',
            'sa': 'South Australia',
            'tas': 'Tasmania',
            'act': 'Australian Capital Territory',
            'nt': 'Northern Territory',
            'other': 'No State Available',
          })}";

  static String m1(symbol, currency) => "${symbol}${currency}";

  static String m2(date) => "${date}";

  static String m3(count) => "Maximum ${count} characters";

  static String m4(count) =>
      "${Intl.plural(count, zero: 'No rent period', one: '1 Month', other: ' ${count} Months ')}";

  static String m5(n) =>
      "Upload ${Intl.plural(n, zero: '(${n}) photo', one: '(${n}) photo', other: '(${n}) photos')}";

  static String m6(description) => "${Intl.select(description, {
            'tenant':
                'You can start browsing properties, connect directly to home owner/ agencies, upload your rental application.',
            'homeowner':
                'You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process.',
            'other': '',
          })}";

  static String m7(role) => "${Intl.select(role, {
            'tenant': 'Tenant',
            'homeowner': 'Homeowner',
            'other': '',
          })}";

  static String m8(number) => "${number} views today";

  static String m9(name) => "👋 Hi ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addBedroomViewInstructions": MessageLookupByLibrary.simpleMessage(
            "How many bedrooms, bathrooms, car spaces?"),
        "addHomeOwnerPrimaryBtnLabel":
            MessageLookupByLibrary.simpleMessage("Add Homeowner role"),
        "addHomeOwnerRoleContent": MessageLookupByLibrary.simpleMessage(
            "Tenant can not use this feature. Would you like to add the role Homeowner to the list of roles?"),
        "addHomeOwnerRoleTitle":
            MessageLookupByLibrary.simpleMessage("Add Homeowner role"),
        "addHomeOwnerSecondaryBtnLabel":
            MessageLookupByLibrary.simpleMessage("Later"),
        "airConditioners":
            MessageLookupByLibrary.simpleMessage("Air conditioners"),
        "allPhotos": MessageLookupByLibrary.simpleMessage("All Photos"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have account ?"),
        "apartment": MessageLookupByLibrary.simpleMessage("Apartment"),
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
        "appleSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "askFeaturesOwned": MessageLookupByLibrary.simpleMessage(
            "Which features your place has?"),
        "australiaState": m0,
        "available": MessageLookupByLibrary.simpleMessage("Available"),
        "availableDate": MessageLookupByLibrary.simpleMessage("Available date"),
        "availableDateColon":
            MessageLookupByLibrary.simpleMessage("Available: "),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "bathroomText": MessageLookupByLibrary.simpleMessage("Bathrooms"),
        "bedroomText": MessageLookupByLibrary.simpleMessage("Bedrooms"),
        "booking": MessageLookupByLibrary.simpleMessage("Booking"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseKindOfYourProperty": MessageLookupByLibrary.simpleMessage(
            "Choose kind of your property"),
        "chooseUserRole":
            MessageLookupByLibrary.simpleMessage("Choose your role"),
        "chooseUserRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can be tenant or homeowner"),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "coverPhoto": MessageLookupByLibrary.simpleMessage("Cover photo"),
        "currencyFormatter": m1,
        "dateFormatter": m2,
        "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "displayName": MessageLookupByLibrary.simpleMessage("Display name"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "electricStove": MessageLookupByLibrary.simpleMessage("Electric stove"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Email"),
        "enterPostalCode":
            MessageLookupByLibrary.simpleMessage("Enter postcode"),
        "enterPrice": MessageLookupByLibrary.simpleMessage("Enter price"),
        "enterPropertyName":
            MessageLookupByLibrary.simpleMessage("Enter property name"),
        "enterSuburb": MessageLookupByLibrary.simpleMessage("Enter suburb"),
        "enterYourAddress":
            MessageLookupByLibrary.simpleMessage("Enter your address"),
        "enterYourDescription":
            MessageLookupByLibrary.simpleMessage("Enter description"),
        "enterYourPostcode":
            MessageLookupByLibrary.simpleMessage("Enter postcode"),
        "enterYourPrice":
            MessageLookupByLibrary.simpleMessage("Enter your price"),
        "enterYourSuburb": MessageLookupByLibrary.simpleMessage("Enter suburb"),
        "enterYourUnitnumber":
            MessageLookupByLibrary.simpleMessage("Enter unit number"),
        "explore": MessageLookupByLibrary.simpleMessage("Explore"),
        "facebookSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Facebook"),
        "favoriteLists": MessageLookupByLibrary.simpleMessage("Favorite lists"),
        "fridge": MessageLookupByLibrary.simpleMessage("Fridge"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full name"),
        "goToSetting": MessageLookupByLibrary.simpleMessage("Go to Setting"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Google"),
        "hatSpaceWouldLikeToPhotoAccess": MessageLookupByLibrary.simpleMessage(
            "\"HATSpace\" Would Like to Photo Access"),
        "homePageViewTitle": MessageLookupByLibrary.simpleMessage("Home Page"),
        "house": MessageLookupByLibrary.simpleMessage("House"),
        "houseNumberAndStreetName":
            MessageLookupByLibrary.simpleMessage("House number + Street name"),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "kitchen": MessageLookupByLibrary.simpleMessage("Kitchen"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "letAddSomePhotosOfYourPlace": MessageLookupByLibrary.simpleMessage(
            "Let\'s add some photos of your place"),
        "linearProgressIndicator":
            MessageLookupByLibrary.simpleMessage("Linear progress indicator"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log out"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginDescription": MessageLookupByLibrary.simpleMessage(
            "You need to be logged in to view this content"),
        "lostDataDescription": MessageLookupByLibrary.simpleMessage(
            "Your data may be lost if you cancel adding new property. Are you sure you want to cancel?"),
        "lostDataTitle": MessageLookupByLibrary.simpleMessage("Lost Data"),
        "maximumChars": m3,
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "minimumRentPeriod":
            MessageLookupByLibrary.simpleMessage("Minimum rent period"),
        "myAccount": MessageLookupByLibrary.simpleMessage("My account"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "myProperties": MessageLookupByLibrary.simpleMessage("My properties"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noLater": MessageLookupByLibrary.simpleMessage("No, later"),
        "notUpdated": MessageLookupByLibrary.simpleMessage("Not updated"),
        "numberFieldContainsNonNumber":
            MessageLookupByLibrary.simpleMessage("Only accept number"),
        "optional": MessageLookupByLibrary.simpleMessage("(Optional)"),
        "otherInformation":
            MessageLookupByLibrary.simpleMessage("Other information"),
        "parkingText": MessageLookupByLibrary.simpleMessage("Car spaces"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone number"),
        "pleaseEnterYourPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Please Enter Your Placeholder"),
        "pleaseSelectRentPeriod":
            MessageLookupByLibrary.simpleMessage("Please select rent period"),
        "pleaseSelectValue":
            MessageLookupByLibrary.simpleMessage("Please select value"),
        "pleaseSelectYourState":
            MessageLookupByLibrary.simpleMessage("Pleas select your state"),
        "plsGoToSettingsAndAllowPhotoAccessForHatSpace":
            MessageLookupByLibrary.simpleMessage(
                "Please go to Settings and allow photos access for HATSpace."),
        "portableFans": MessageLookupByLibrary.simpleMessage("Portable Fans"),
        "postcode": MessageLookupByLibrary.simpleMessage("Postcode"),
        "preview": MessageLookupByLibrary.simpleMessage("Preview"),
        "previewAndSubmit":
            MessageLookupByLibrary.simpleMessage("Preview & Submit"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "propertyFeatures":
            MessageLookupByLibrary.simpleMessage("Property features"),
        "propertyName": MessageLookupByLibrary.simpleMessage("Property name"),
        "pw": MessageLookupByLibrary.simpleMessage("pw"),
        "rentPeriod": m4,
        "requireAtLeast4Photos":
            MessageLookupByLibrary.simpleMessage("Require at least 4 photos *"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchHint":
            MessageLookupByLibrary.simpleMessage("Search rental, location..."),
        "securityCameras":
            MessageLookupByLibrary.simpleMessage("Security cameras"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signinErrorToastMessage": MessageLookupByLibrary.simpleMessage(
            "Unable to sign you in at the moment. Please try again later."),
        "signinErrorToastTitle":
            MessageLookupByLibrary.simpleMessage("Login Failed"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "streetAddress": MessageLookupByLibrary.simpleMessage("Street address"),
        "suburb": MessageLookupByLibrary.simpleMessage("Suburb"),
        "swimmingPool": MessageLookupByLibrary.simpleMessage("Swimming pool"),
        "textWithInvalidChars":
            MessageLookupByLibrary.simpleMessage("Only accept text"),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "tv": MessageLookupByLibrary.simpleMessage("TV"),
        "unitNumber": MessageLookupByLibrary.simpleMessage("Unit number"),
        "upload": MessageLookupByLibrary.simpleMessage("Upload"),
        "uploadPhotoCount": m5,
        "userRoleDescription": m6,
        "userTitleRoles": m7,
        "viewProfile": MessageLookupByLibrary.simpleMessage("View profile"),
        "viewsToday": m8,
        "washingMachine":
            MessageLookupByLibrary.simpleMessage("Washing machine"),
        "welcomeDefault": MessageLookupByLibrary.simpleMessage("👋 Hi there"),
        "welcomeName": m9,
        "whatKindOfPlace":
            MessageLookupByLibrary.simpleMessage("What kind of place?"),
        "wifi": MessageLookupByLibrary.simpleMessage("Wifi"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "yesLoginNow": MessageLookupByLibrary.simpleMessage("Yes, login now"),
        "yourAddress": MessageLookupByLibrary.simpleMessage("Your address")
      };
}
