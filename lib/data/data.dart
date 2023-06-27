import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';

class UserDetail {
  final String uid;
  final String? phone;
  final String? email;
  final String? displayName;

  UserDetail({required this.uid, this.phone, this.email, this.displayName});
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) => values
      .firstWhere((element) => element.name == name, orElse: () => tenant);
}

enum PropertyTypes {
  house,
  apartment;

  const PropertyTypes();

  String getIconPath() {
    switch (this) {
      case house:
        return Assets.images.house;
      case apartment:
        return Assets.images.apartment;
      default:
    }
    return 'No image path';
  }

  String get displayName {
    switch (this) {
      case PropertyTypes.house:
        return HatSpaceStrings.current.house;
      case PropertyTypes.apartment:
        return HatSpaceStrings.current.apartment;
    }
  }

  static PropertyTypes? fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}
