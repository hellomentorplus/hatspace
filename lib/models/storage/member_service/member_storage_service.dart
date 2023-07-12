import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/member.dart';

class MemberService {
  final FirebaseFirestore _firestore;

  final String memberCollection = 'members';
  final String rolesKey = 'roles';
  final String displayNameKey = 'displayName';

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

  Future<void> saveMember(String uid, Set<Roles> roles, String displayName) async{
    Member member = Member(listRoles: roles, displayName: displayName);
    await _firestore.collection(memberCollection)
    .doc(uid).set(member.convertToMap());
  }
}
