import 'package:hatspace/data/data.dart';

class Member {
  final String _rolesKey = 'roles';
  final String _displayNameKey = 'displayName';
  final String _avatarKey = 'avatar';
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
}
