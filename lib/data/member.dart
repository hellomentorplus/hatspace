import 'package:hatspace/data/data.dart';

class Member {
  final rolesKey = 'roles';
  final displayNameKey = 'displayName';
  final Set<Roles> listRoles;
  final String displayName;

  Member({required this.listRoles, required this.displayName});
  convertToMap() {
    return {
      rolesKey: listRoles.map((e) => e.name).toList(),
      displayNameKey: displayName
    };
  }
}
