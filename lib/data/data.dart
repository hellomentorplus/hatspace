class UserDetail {
  final String uid;
  final String? phone;
  final String? email;
  final String? displayName;
  UserDetail({required this.uid, this.phone, this.email, this.displayName}) ;
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) => values
      .firstWhere((element) => element.name == name, orElse: () => tenant);
}
