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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("HAT Space"),
        "cancelBtn": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chooseUserRole":
            MessageLookupByLibrary.simpleMessage("Choose your role"),
        "chooseUserRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can be tenant or homeowner, OR you can be both."),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "explore": MessageLookupByLibrary.simpleMessage("Explore"),
        "homeowner": MessageLookupByLibrary.simpleMessage("Homeowner"),
        "homeownerRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can start putting up your property advertisement, shortlist your potential tenants, tracking leasing process."),
        "inbox": MessageLookupByLibrary.simpleMessage("Inbox"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "tenant": MessageLookupByLibrary.simpleMessage("Tenant"),
        "tenantRoleDescription": MessageLookupByLibrary.simpleMessage(
            "You can start browsing properties, connect directly to home owner/ agencies, upload your rental application."),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking")
      };
}
