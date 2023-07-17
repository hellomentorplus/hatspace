import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

class UserDetail {
  final String uid;
  final String? phone;
  final String? email;
  final String? displayName;
  final String? avatar;

  UserDetail(
      {required this.uid,
      this.phone,
      this.email,
      this.displayName,
      this.avatar});
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) => values
      .firstWhere((element) => element.name == name, orElse: () => tenant);

  String get title {
    switch (this) {
      case Roles.tenant:
        return HatSpaceStrings.current.userTitleRoles(Roles.tenant.name);
      case Roles.homeowner:
        return HatSpaceStrings.current.userTitleRoles(Roles.homeowner.name);
    }
  }

  String get description {
    switch (this) {
      case Roles.tenant:
        return HatSpaceStrings.current.userRoleDescription(Roles.tenant.name);
      case Roles.homeowner:
        return HatSpaceStrings.current
            .userRoleDescription(Roles.homeowner.name);
    }
  }

  String get iconSvgPath {
    switch (this) {
      case Roles.tenant:
        return Assets.icons.tenant;
      case Roles.homeowner:
        return Assets.icons.homeowner;
    }
  }
}
