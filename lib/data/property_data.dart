enum PropertyTypes {
  house,
  apartment,
  invalid;

  static PropertyTypes fromName(String name) {
    return values.firstWhere((element) => element.name == name,
        orElse: () => invalid);
  }
}
