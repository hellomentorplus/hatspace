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
        "addressHints":
            MessageLookupByLibrary.simpleMessage("House number + Street name"),
        "addressLabel": MessageLookupByLibrary.simpleMessage("Address"),
        "addressPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter address"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have account ?"),
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
        "booking": MessageLookupByLibrary.simpleMessage("Booking"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseUserRole":
            MessageLookupByLibrary.simpleMessage("Choose your role"),
        "chooseUserRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can be tenant or homeowner, OR you can be both."),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "descriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
        "descriptionPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter description"),
        "emailSignUp":
            MessageLookupByLibrary.simpleMessage("Sign up with email"),
        "explore": MessageLookupByLibrary.simpleMessage("Explore"),
        "facebookSignUp":
            MessageLookupByLibrary.simpleMessage("Sign up with Facebook"),
        "googleSignUp":
            MessageLookupByLibrary.simpleMessage("Sign up with Google"),
        "homePageViewTitle": MessageLookupByLibrary.simpleMessage("Home Page"),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "linearProgressIndicator":
            MessageLookupByLibrary.simpleMessage("Linear progress indicator"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "minimumRentPeriodlabel":
            MessageLookupByLibrary.simpleMessage("Minimum rent period"),
        "nsw": MessageLookupByLibrary.simpleMessage("New South Wales"),
        "nt": MessageLookupByLibrary.simpleMessage("Northern Territory"),
        "optional": MessageLookupByLibrary.simpleMessage("Optional"),
        "postcodeLabel": MessageLookupByLibrary.simpleMessage("Postcode"),
        "postcodePlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter postcode"),
        "priceLabel": MessageLookupByLibrary.simpleMessage("Price"),
        "pricePlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter your price"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "propertyNameLabel":
            MessageLookupByLibrary.simpleMessage("Property name"),
        "propertyNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter property name"),
        "qld": MessageLookupByLibrary.simpleMessage("Queenland"),
        "sa": MessageLookupByLibrary.simpleMessage("South Australia"),
        "searchHint":
            MessageLookupByLibrary.simpleMessage("Search rental, location..."),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinErrorToastMessage": MessageLookupByLibrary.simpleMessage(
            "Unable to sign you in at the moment. Please try again later."),
        "signinErrorToastTitle":
            MessageLookupByLibrary.simpleMessage("Login Failed"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6 Months"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "stateLabel": MessageLookupByLibrary.simpleMessage("State"),
        "suburbLabel": MessageLookupByLibrary.simpleMessage("Suburb"),
        "suburbPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter suburb"),
        "tas": MessageLookupByLibrary.simpleMessage("Tasmania"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3 Months"),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "unitNumberLabel": MessageLookupByLibrary.simpleMessage("Unit number"),
        "unitNumberPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter unit number"),
        "userRoleDescription": m0,
        "userTitleRoles": m1,
        "vic": MessageLookupByLibrary.simpleMessage("Victoria"),
        "wa": MessageLookupByLibrary.simpleMessage("Western Australia")
      };
}
