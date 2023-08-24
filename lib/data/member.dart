import 'package:hatspace/data/data.dart';

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
