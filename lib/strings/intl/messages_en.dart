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
            'qld': 'Queenland',
            'wa': 'Western Australia',
            'sa': 'South Australia',
            'tas': 'Tasmania',
            'act': 'Australian Capital Territory',
            'nt': 'Northern Territory',
            'other': 'No State Available',
          })}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'No rent period', one: '1 Month', other: ' ${count} Months ')}";

  static String m2(description) => "${Intl.select(description, {
            'tenant':
                'You can start browsing properties, connect directly to home owner/ agencies, upload your rental application.',
            'homeowner':
                'You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process.',
            'other': '',
          })}";

  static String m3(role) => "${Intl.select(role, {
            'tenant': 'Tenant',
            'homeowner': 'Homeowner',
            'other': '',
          })}";

  static String m4(name) => "👋 Hi ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addBedroomViewInstructions": MessageLookupByLibrary.simpleMessage(
            "How many bedrooms, bathrooms, car spaces?"),
        "airConditioners":
            MessageLookupByLibrary.simpleMessage("Air conditioners"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have account ?"),
        "apartment": MessageLookupByLibrary.simpleMessage("Apartment"),
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
        "askFeaturesOwned": MessageLookupByLibrary.simpleMessage(
            "Which features your place has?"),
        "australiaState": m0,
        "availableDate": MessageLookupByLibrary.simpleMessage("Available date"),
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
            "You can be tenant or homeowner, OR you can be both."),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "electricStove": MessageLookupByLibrary.simpleMessage("Electric stove"),
        "emailSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Email"),
        "enterPropertyName":
            MessageLookupByLibrary.simpleMessage("Enter property name"),
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
        "fridge": MessageLookupByLibrary.simpleMessage("Fridge"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Google"),
        "homePageViewTitle": MessageLookupByLibrary.simpleMessage("Home Page"),
        "house": MessageLookupByLibrary.simpleMessage("House"),
        "houseNumberAndStreetName":
            MessageLookupByLibrary.simpleMessage("House number + Street name"),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "kitchen": MessageLookupByLibrary.simpleMessage("Kitchen"),
        "letAddSomePhotosOfYourPlace": MessageLookupByLibrary.simpleMessage(
            "Let\'s add some photos of your place"),
        "linearProgressIndicator":
            MessageLookupByLibrary.simpleMessage("Linear progress indicator"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "minimumRentPeriod":
            MessageLookupByLibrary.simpleMessage("Minimum rent period"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "optional": MessageLookupByLibrary.simpleMessage("(Optional)"),
        "parkingText": MessageLookupByLibrary.simpleMessage("Car spaces"),
        "pleaseEnterYourPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Please Enter Your Placeholder"),
        "pleaseSelectRentPeriod":
            MessageLookupByLibrary.simpleMessage("Please select rent period"),
        "pleaseSelectValue":
            MessageLookupByLibrary.simpleMessage("Please select value"),
        "pleaseSelectYourState":
            MessageLookupByLibrary.simpleMessage("Pleas select your state"),
        "portableFans": MessageLookupByLibrary.simpleMessage("Portable Fans"),
        "postcode": MessageLookupByLibrary.simpleMessage("Postcode"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "propertyName": MessageLookupByLibrary.simpleMessage("Property name"),
        "rentPeriod": m1,
        "requireAtLeast4Photos":
            MessageLookupByLibrary.simpleMessage("Require at least 4 photos *"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchHint":
            MessageLookupByLibrary.simpleMessage("Search rental, location..."),
        "securityCameras":
            MessageLookupByLibrary.simpleMessage("Security cameras"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinErrorToastMessage": MessageLookupByLibrary.simpleMessage(
            "Unable to sign you in at the moment. Please try again later."),
        "signinErrorToastTitle":
            MessageLookupByLibrary.simpleMessage("Login Failed"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "streetAddress": MessageLookupByLibrary.simpleMessage("Street address"),
        "suburb": MessageLookupByLibrary.simpleMessage("Suburb"),
        "swimmingPool": MessageLookupByLibrary.simpleMessage("Swimming pool"),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "tv": MessageLookupByLibrary.simpleMessage("TV"),
        "unitNumber": MessageLookupByLibrary.simpleMessage("Unit number"),
        "userRoleDescription": m2,
        "userTitleRoles": m3,
        "washingMachine":
            MessageLookupByLibrary.simpleMessage("Washing machine"),
        "welcomeDefault": MessageLookupByLibrary.simpleMessage("Hi there 👋"),
        "welcomeName": m4,
        "whatKindOfPlace":
            MessageLookupByLibrary.simpleMessage("What kind of place?"),
        "wifi": MessageLookupByLibrary.simpleMessage("Wifi"),
        "yourAddress": MessageLookupByLibrary.simpleMessage("Your address")
      };
}
