import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/member.dart';

class MemberService {
  final FirebaseFirestore _firestore;

  final String memberCollection = 'members';
  final String rolesKey = 'roles';
  final String displayNameKey = 'displayName';
  final String propertiesKey = 'properties';

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
    await _firestore
        .collection(memberCollection)
        .doc(uid)
        .set({rolesKey: roles.map((e) => e.name).toList()});
  }

  Future<void> saveMember(
      String uid, Set<Roles> roles, String displayName) async {
    Member member = Member(listRoles: roles, displayName: displayName);
    await _firestore
        .collection(memberCollection)
        .doc(uid)
        .set(member.convertToMap(), SetOptions(merge: true));
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
}
