class UserDetail {
  final String uid;
  final String? phone;
  final String? email;
  final String? displayName;
  final String? avatar;

  UserDetail({required this.uid, this.phone, this.email, this.displayName, this.avatar});
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) => values
      .firstWhere((element) => element.name == name, orElse: () => tenant);
}
