import 'package:flutter/foundation.dart';

import 'member_service/member_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final MemberService _member = MemberService(_firestore);

  MemberService get member => _member;

  @protected
  @visibleForTesting
  static set firestore(FirebaseFirestore firestore) => _firestore = firestore;
}
