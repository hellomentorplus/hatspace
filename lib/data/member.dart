import 'package:hatspace/data/data.dart';

enum CountryCallingCode {
  //TODO: add more value for upcomming story
  au('+61'),
  invalid('invalid');

  const CountryCallingCode(this.country);
  final String country;
  String get code => country;

  // static MinimumRentPeriod fromMonthsValue(int months) => values
  //     .firstWhere((element) => element.months == months, orElse: () => invalid);
}

class PhoneNumber {
  final String _countryCodeKey = 'countryCode';
  final String _numberKey = 'numberKey';
  CountryCallingCode countryCode;
  String phoneNumber;
  PhoneNumber({
    required this.countryCode,
    required this.phoneNumber,
  });

  Map<String, dynamic> convertToMap() {
    return {_countryCodeKey: countryCode.code, _numberKey: phoneNumber};
  }
}

class Member {
  final String _rolesKey = 'roles';
  static const String _displayNameKey = 'displayName';
  static const String _avatarKey = 'avatar';
  final Set<Roles> listRoles;
  final String displayName;
  final String? avatar;

  Member(
      {required this.listRoles,
      required this.displayName,
      required this.avatar});
  //Allow to convert to Map type, which is used to store on Firestore
  Map<String, dynamic> convertToMap() {
    return {
      _rolesKey: listRoles.map((e) => e.name).toList(),
      _displayNameKey: displayName,
      _avatarKey: avatar,
    };
  }

  static Map<String, dynamic> nameAndAvatarMap(
      String displayName, String? avatar) {
    return {
      _displayNameKey: displayName,
      _avatarKey: avatar,
    };
  }
}
