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

  static String m0(name, symbol) => "${name} (${symbol})";

  static String m1(ausState) => "${Intl.select(ausState, {
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

  static String m2(symbol, currency) => "${symbol}${currency}";

  static String m3(date) => "${date}";

  static String m4(date) => "${date}";

  static String m5(datetime) => "User${datetime}";

  static String m6(count) => "Maximum ${count} characters";

  static String m7(number) =>
      "${Intl.plural(number, zero: '0 Booking', one: '1 Booking', other: ' ${number} Bookings')}";

  static String m8(number) => "${number} inspection booking";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'No rent period', one: '1 Month', other: ' ${count} Months ')}";

  static String m10(counter) => "Show more (${counter})";

  static String m11(dateTime) => "${dateTime}";

  static String m12(n) =>
      "Upload ${Intl.plural(n, zero: '(${n}) photo', one: '(${n}) photo', other: '(${n}) photos')}";

  static String m13(description) => "${Intl.select(description, {
            'tenant':
                'You can explore properties, connect directly to homeowners, upload your rental application.',
            'homeowner':
                'You can upload and manage your properties, shortlist potential tenants, track the leasing process.',
            'other': ' ',
          })}";

  static String m14(role) => "${Intl.select(role, {
            'tenant': 'Tenant',
            'homeowner': 'Homeowner',
            'other': ' ',
          })}";

  static String m15(number) => "${number} views today";

  static String m16(name) => "👋 Hi ${name}";

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
        "addInspectionBooking":
            MessageLookupByLibrary.simpleMessage("Add an inspection booking"),
        "addPropertyPriceDisplay": m0,
        "addPropertyRentalPeriodUnit":
            MessageLookupByLibrary.simpleMessage("(PW)"),
        "addTenantRole":
            MessageLookupByLibrary.simpleMessage("Add Tenant Role"),
        "addTenantRoleBottomSheetDescription": MessageLookupByLibrary.simpleMessage(
            "Only Tenant can use this feature. Would you like to add the role Tenant to the list of roles?"),
        "addTenantRoleBottomSheetTitle":
            MessageLookupByLibrary.simpleMessage("Add Tenant role"),
        "addToGoolgeCalendar":
            MessageLookupByLibrary.simpleMessage("Add to Goolge Calendar"),
        "airConditioners":
            MessageLookupByLibrary.simpleMessage("Air conditioners"),
        "allPhotos": MessageLookupByLibrary.simpleMessage("All Photos"),
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have account ?"),
        "apartment": MessageLookupByLibrary.simpleMessage("Apartment"),
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
        "appleSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "application": MessageLookupByLibrary.simpleMessage("Application"),
        "applicationBankStatement":
            MessageLookupByLibrary.simpleMessage("Current bank statement"),
        "applicationContactNumber":
            MessageLookupByLibrary.simpleMessage("0413856056"),
        "applicationEmail":
            MessageLookupByLibrary.simpleMessage("Hello@the-hat.life"),
        "applicationIdentification": MessageLookupByLibrary.simpleMessage(
            "Identification (driver\'s license/passport)"),
        "applicationInform": MessageLookupByLibrary.simpleMessage(
            "All adult applicants (18 years or older) must complete a separate application for rental."),
        "applicationPaySlips": MessageLookupByLibrary.simpleMessage(
            "Pay slips/centre link statement"),
        "applicationReference": MessageLookupByLibrary.simpleMessage(
            "Tenancy ledger/rental reference"),
        "applicationRequirementsAsking": MessageLookupByLibrary.simpleMessage(
            "Please provide the following with your application:"),
        "applicationSubject":
            MessageLookupByLibrary.simpleMessage("Application for rental"),
        "askFeaturesOwned": MessageLookupByLibrary.simpleMessage(
            "Which features your place has?"),
        "australiaState": m1,
        "available": MessageLookupByLibrary.simpleMessage("Available"),
        "availableDate": MessageLookupByLibrary.simpleMessage("Available date"),
        "availableDateColon":
            MessageLookupByLibrary.simpleMessage("Available: "),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "bathroomText": MessageLookupByLibrary.simpleMessage("Bathrooms"),
        "bedroomText": MessageLookupByLibrary.simpleMessage("Bedrooms"),
        "bookInspection":
            MessageLookupByLibrary.simpleMessage("Book Inspection"),
        "bookingInspectionSuccessTitle":
            MessageLookupByLibrary.simpleMessage("🎉 Congratulations!"),
        "bookingSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Your booking is successfully saved and sent to homeowner. To complete the booking, please wait for the confirmation from homeowner."),
        "btnLogOut": MessageLookupByLibrary.simpleMessage("Log Out"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseKindOfYourProperty": MessageLookupByLibrary.simpleMessage(
            "Choose kind of your property"),
        "chooseUserRole":
            MessageLookupByLibrary.simpleMessage("Choose your role"),
        "chooseUserRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can be a tenant or homeowner or both"),
        "congratulations":
            MessageLookupByLibrary.simpleMessage("Congratulations 🎉"),
        "contactSupport":
            MessageLookupByLibrary.simpleMessage("Support contact"),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "countryCode": MessageLookupByLibrary.simpleMessage("AUS (+61)"),
        "coverPhoto": MessageLookupByLibrary.simpleMessage("Cover photo"),
        "currencyFormatter": m2,
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "dateFormatter": m3,
        "dateFormatterWithDate": m4,
        "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
        "defaultUserDisplayName": m5,
        "deleteAccount": MessageLookupByLibrary.simpleMessage("Delete account"),
        "deleteAccountQuestionMark":
            MessageLookupByLibrary.simpleMessage("Delete account?"),
        "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
            "All your data will be kept within 30 days before being deleted permanently. Are you sure you want to delete your account?"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "details": MessageLookupByLibrary.simpleMessage("Details"),
        "displayName": MessageLookupByLibrary.simpleMessage("Display name"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloadApplicationFormHere": MessageLookupByLibrary.simpleMessage(
            "Download Application form here"),
        "duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "durationPlaceHolder": MessageLookupByLibrary.simpleMessage("15 mins"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "electricStove": MessageLookupByLibrary.simpleMessage("Electric stove"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailSignUp":
            MessageLookupByLibrary.simpleMessage("Continue with Email"),
        "end": MessageLookupByLibrary.simpleMessage("End"),
        "endTime": MessageLookupByLibrary.simpleMessage("End time"),
        "enterPostalCode":
            MessageLookupByLibrary.simpleMessage("Enter postcode"),
        "enterPrice": MessageLookupByLibrary.simpleMessage("Enter price"),
        "enterPropertyName":
            MessageLookupByLibrary.simpleMessage("Enter property name"),
        "enterStreetAddress":
            MessageLookupByLibrary.simpleMessage("Enter street address"),
        "enterSuburb": MessageLookupByLibrary.simpleMessage("Enter suburb"),
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
        "guideForApplication":
            MessageLookupByLibrary.simpleMessage("Guide for application"),
        "hatSpaceWouldLikeToPhotoAccess": MessageLookupByLibrary.simpleMessage(
            "\"HATspace\" Would Like to Photo Access"),
        "homePageViewTitle": MessageLookupByLibrary.simpleMessage("Home Page"),
        "house": MessageLookupByLibrary.simpleMessage("House"),
        "houseNumberAndStreetName":
            MessageLookupByLibrary.simpleMessage("House number + Street name"),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "inspection": MessageLookupByLibrary.simpleMessage("Inspection"),
        "inspectionBooking":
            MessageLookupByLibrary.simpleMessage("Inspection Booking"),
        "kitchen": MessageLookupByLibrary.simpleMessage("Kitchen"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "letAddSomePhotosOfYourPlace": MessageLookupByLibrary.simpleMessage(
            "Let\'s add some photos of your place"),
        "linearProgressIndicator":
            MessageLookupByLibrary.simpleMessage("Linear progress indicator"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log out"),
        "logOutDescription": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to log out?"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginDescription": MessageLookupByLibrary.simpleMessage(
            "You need to be logged in to view this content"),
        "lostDataDescription": MessageLookupByLibrary.simpleMessage(
            "Your data may be lost if you cancel adding new property. Are you sure you want to cancel?"),
        "lostDataTitle": MessageLookupByLibrary.simpleMessage("Lost Data"),
        "managePropertyButton":
            MessageLookupByLibrary.simpleMessage("Manage property"),
        "maximumChars": m6,
        "minimumRentPeriod":
            MessageLookupByLibrary.simpleMessage("Minimum rent period"),
        "minuteShort": MessageLookupByLibrary.simpleMessage("Mins"),
        "myAccount": MessageLookupByLibrary.simpleMessage("My account"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "myProperties": MessageLookupByLibrary.simpleMessage("My properties"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noBooking": MessageLookupByLibrary.simpleMessage("No booking"),
        "noLater": MessageLookupByLibrary.simpleMessage("No, later"),
        "notUpdated": MessageLookupByLibrary.simpleMessage("Not updated"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesPlaceHolder": MessageLookupByLibrary.simpleMessage(
            "Write a message to homeowner"),
        "numberFieldContainsNonNumber":
            MessageLookupByLibrary.simpleMessage("Only accept number"),
        "numberOfBooking": m7,
        "numberOfInspectionBooking": m8,
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
                "Please go to Settings and allow photos access for HATspace."),
        "pm": MessageLookupByLibrary.simpleMessage("pm"),
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
        "questionSupport": MessageLookupByLibrary.simpleMessage(
            "If you have any questions, please feel free to let us know. We will always here to support you!"),
        "rentPeriod": m9,
        "requireAtLeast4Photos":
            MessageLookupByLibrary.simpleMessage("Require at least 4 photos *"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchHint":
            MessageLookupByLibrary.simpleMessage("Search rental, location..."),
        "securityCameras":
            MessageLookupByLibrary.simpleMessage("Security cameras"),
        "selectStartTimeError":
            MessageLookupByLibrary.simpleMessage("Select start time"),
        "sendEmail": MessageLookupByLibrary.simpleMessage("Send Email"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showLess": MessageLookupByLibrary.simpleMessage("Show less"),
        "showMore": MessageLookupByLibrary.simpleMessage("Show more"),
        "showMoreCounter": m10,
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signinErrorToastMessage": MessageLookupByLibrary.simpleMessage(
            "Unable to sign you in at the moment. Please try again later."),
        "signinErrorToastTitle":
            MessageLookupByLibrary.simpleMessage("Login Failed"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "startTime": MessageLookupByLibrary.simpleMessage("Start time"),
        "startTimePlaceholder": MessageLookupByLibrary.simpleMessage("9:00 AM"),
        "state": MessageLookupByLibrary.simpleMessage("State"),
        "streetAddress": MessageLookupByLibrary.simpleMessage("Street address"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "suburb": MessageLookupByLibrary.simpleMessage("Suburb"),
        "successAddingPropertyMessage": MessageLookupByLibrary.simpleMessage(
            "You have successfully added your new property!"),
        "swimmingPool": MessageLookupByLibrary.simpleMessage("Swimming pool"),
        "textWithInvalidChars":
            MessageLookupByLibrary.simpleMessage("Only accept text"),
        "timeFormatter": m11,
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "tv": MessageLookupByLibrary.simpleMessage("TV"),
        "unitNumber": MessageLookupByLibrary.simpleMessage("Unit number"),
        "updatePhoneLabel": MessageLookupByLibrary.simpleMessage(
            "2 digit area code + 8 digit local phone number"),
        "updatePhonePlaceHolder":
            MessageLookupByLibrary.simpleMessage("0XXX XXX XXX"),
        "updateProfile": MessageLookupByLibrary.simpleMessage("Update profile"),
        "upload": MessageLookupByLibrary.simpleMessage("Upload"),
        "uploadPhotoCount": m12,
        "userRoleDescription": m13,
        "userTitleRoles": m14,
        "viewProfile": MessageLookupByLibrary.simpleMessage("View profile"),
        "viewsToday": m15,
        "washingMachine":
            MessageLookupByLibrary.simpleMessage("Washing machine"),
        "welcomeDefault": MessageLookupByLibrary.simpleMessage("👋 Hi there"),
        "welcomeName": m16,
        "whatKindOfPlace":
            MessageLookupByLibrary.simpleMessage("What kind of place?"),
        "wifi": MessageLookupByLibrary.simpleMessage("Wifi"),
        "wrongCodeAreaErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Area code: 02, 03, 04, 05, 07, 08"),
        "wrongLenghtPhongNumerErrorMessage":
            MessageLookupByLibrary.simpleMessage("Must be 10 digits"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "yesLoginNow": MessageLookupByLibrary.simpleMessage("Yes, login now"),
        "yourAddress": MessageLookupByLibrary.simpleMessage("Your address")
      };
}
