import 'package:hatspace/gen/assets.gen.dart';

class UserDetail {
  final String uid;
  final String? phone;
  final String? email;

  UserDetail({required this.uid, this.phone, this.email});
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

enum PropertyTypes {
  house,
  apartment;

  const PropertyTypes();

   String getIconPath (){
    switch (this) {
      case house:
          return Assets.images.house;
      case apartment:
          return Assets.images.apartment;
      default:
    }
    return "No image path";
  }

  static PropertyTypes fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}