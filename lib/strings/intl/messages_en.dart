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

  static String m0(description) => "${Intl.select(description, {
            'tenant':
                'You can start browsing properties, connect directly to home owner/ agencies, upload your rental application.',
            'homeowner':
                'You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process.',
            'other': '',
          })}";

  static String m1(role) => "${Intl.select(role, {
            'tenant': 'Tenant',
            'homeowner': 'Homeowner',
            'other': '',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "act": MessageLookupByLibrary.simpleMessage(
            "Australian Capital Territory"),
        "addBedroomViewInstructions": MessageLookupByLibrary.simpleMessage(
            "How many bedrooms, bathrooms, parking?"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have account ?"),
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
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
        "eighteenMonths": MessageLookupByLibrary.simpleMessage("18 Months"),
        "emailSignUp":
            MessageLookupByLibrary.simpleMessage("Sign up with email"),
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
            MessageLookupByLibrary.simpleMessage("Sign up with Facebook"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Sign up with Google"),
        "homePageViewTitle": MessageLookupByLibrary.simpleMessage("Home Page"),
        "houseNumberAndStreetName":
            MessageLookupByLibrary.simpleMessage("House number + Street name"),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "linearProgressIndicator":
            MessageLookupByLibrary.simpleMessage("Linear progress indicator"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "minimumRentPeriod":
            MessageLookupByLibrary.simpleMessage("Minimum rent period"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "nineMonths": MessageLookupByLibrary.simpleMessage("9 Months"),
        "nsw": MessageLookupByLibrary.simpleMessage("New South Wales"),
        "nt": MessageLookupByLibrary.simpleMessage("Northern Territory"),
        "oneMonths": MessageLookupByLibrary.simpleMessage("1 Months"),
        "optional": MessageLookupByLibrary.simpleMessage("Optional"),
        "parkingText": MessageLookupByLibrary.simpleMessage("Parkings"),
        "pleaseEnterYourPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Please Enter Your Placeholder"),
        "pleaseSelectRentPeriod":
            MessageLookupByLibrary.simpleMessage("Please select rent period"),
        "pleaseSelectYourState":
            MessageLookupByLibrary.simpleMessage("Pleas select your state"),
        "postcode": MessageLookupByLibrary.simpleMessage("Postcode"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "propertyName": MessageLookupByLibrary.simpleMessage("Property name"),
        "qld": MessageLookupByLibrary.simpleMessage("Queenland"),
        "sa": MessageLookupByLibrary.simpleMessage("South Australia"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchHint":
            MessageLookupByLibrary.simpleMessage("Search rental, location..."),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinErrorToastMessage": MessageLookupByLibrary.simpleMessage(
            "Unable to sign you in at the moment. Please try again later."),
        "signinErrorToastTitle":
            MessageLookupByLibrary.simpleMessage("Login Failed"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6 Months"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "streetAddress": MessageLookupByLibrary.simpleMessage("Street address"),
        "suburb": MessageLookupByLibrary.simpleMessage("Suburb"),
        "tas": MessageLookupByLibrary.simpleMessage("Tasmania"),
        "thirtySixMonths": MessageLookupByLibrary.simpleMessage("36 Months"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3 Months"),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "tweentyFourMonths": MessageLookupByLibrary.simpleMessage("24 Months"),
        "twelveMonths": MessageLookupByLibrary.simpleMessage("12 Months"),
        "unitNumber": MessageLookupByLibrary.simpleMessage("Unit number"),
        "userRoleDescription": m0,
        "userTitleRoles": m1,
        "vic": MessageLookupByLibrary.simpleMessage("Victoria"),
        "wa": MessageLookupByLibrary.simpleMessage("Western Australia"),
        "whatKindOfPlace":
            MessageLookupByLibrary.simpleMessage("What kind of place?"),
        "yourAddress": MessageLookupByLibrary.simpleMessage("Your address")
      };
}
