import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';

class MemberService {
  final FirebaseFirestore _firestore;

  final String memberCollection = 'members';
  final String rolesKey = 'roles';
  final String displayNameKey = 'displayName';
  final String propertiesKey = 'properties';
  final String avatarKey = 'avatar';
  final String phoneNumberKey = 'phone';

  MemberService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<List<Roles>> getUserRoles(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> rolesRef = await _firestore
        .collection(memberCollection)
        .doc(uid)
        .get(const GetOptions(source: Source.server));

    if (!rolesRef.exists) {
      return [];
    }

    final Map<String, dynamic>? data = rolesRef.data();
    if (data == null) {
      return [];
    }

    if (data[rolesKey] == null) {
      return [];
    }

    try {
      List<Roles> roles =
          (data[rolesKey] as List).map((e) => Roles.fromName('$e')).toList();
      return roles;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveUserRoles(String uid, Set<Roles> roles) async {
    await _firestore.collection(memberCollection).doc(uid).set(
        {rolesKey: roles.map((e) => e.name).toList()}, SetOptions(merge: true));
  }

  Future<void> saveNameAndAvatar(String uid, String displayName, String? avatar,
      {bool update = false}) async {
    if (update) {
      await _firestore.collection(memberCollection).doc(uid).set(
          {displayNameKey: displayName, avatarKey: avatar},
          SetOptions(merge: true));

      return;
    }

    // not update, then check if current name and avatar are available
    // get current name
    final String currentName = await getMemberDisplayName(uid);
    final String? currentAvatar = await getMemberAvatar(uid);

    if (currentName == displayName && currentAvatar == avatar) {
      // same data, do not save again
      return;
    }

    await _firestore.collection(memberCollection).doc(uid).set({
      displayNameKey: currentName.isEmpty ? displayName : currentName,
      avatarKey: currentAvatar ?? avatar
    }, SetOptions(merge: true));
  }

  Future<void> addMemberProperties(String uid, String propertyId) async {
    // use Set to avoid duplicated property ID
    final Set<String> currentProperties =
        (await getMemberProperties(uid)).toSet()..add(propertyId);

    await _firestore
        .collection(memberCollection)
        .doc(uid)
        .set({propertiesKey: currentProperties}, SetOptions(merge: true));
  }

  Future<List<String>> getMemberProperties(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(memberCollection)
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache));

    if (!snapshot.exists) {
      return [];
    }

    final Map<String, dynamic>? data = snapshot.data();

    if (data == null) {
      return [];
    }

    if (data[propertiesKey] == null) {
      return [];
    }

    final dynamic props = data[propertiesKey];

    if (props is! List<dynamic>) {
      return [];
    }

    return props.map((e) => e.toString()).toList();
  }

  Future<String> getMemberDisplayName(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(memberCollection)
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache));

    if (!snapshot.exists) {
      return '';
    }

    final Map<String, dynamic>? data = snapshot.data();

    if (data == null) {
      return '';
    }

    if (data[displayNameKey] == null) {
      return '';
    }

    final dynamic name = data[displayNameKey];

    if (name is! String) {
      return '';
    }

    return name;
  }

  Future<String?> getMemberAvatar(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(memberCollection)
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache));

    if (!snapshot.exists) {
      return null;
    }

    final Map<String, dynamic>? data = snapshot.data();

    if (data == null) {
      return null;
    }

    if (data[avatarKey] == null) {
      return null;
    }

    final dynamic avatar = data[avatarKey];

    if (avatar is! String) {
      return null;
    }

    return avatar;
  }

  Future<String?> getMemberPhoneNumber(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(memberCollection)
        .doc(uid)
        .get(const GetOptions(source: Source.serverAndCache));
    if (!snapshot.exists) {
      return null;
    }

    final Map<String, dynamic>? data = snapshot.data();

    if (data == null) {
      return null;
    }

    if (data[phoneNumberKey] == null) {
      return null;
    }

    final String phoneNumber = data[phoneNumberKey];

    return phoneNumber;
  }

  // TODO: SAVE AND UPLOAD TO DATABASE
  // Future<void> savePhoneNumberDetail(String uid, PhoneNumber number) async {
  //   await _firestore
  //       .collection(memberCollection)
  //       .doc(uid)
  //       .set({phoneNumberKey: number.convertToMap()}, SetOptions(merge: true));
  //   return;
  // }
}
