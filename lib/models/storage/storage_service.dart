import 'package:flutter/foundation.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';

import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final MemberService _member = MemberService(_firestore);
  final PropertyService _propertyService = PropertyService(_firestore);

  MemberService get member => _member;
  PropertyService get property => _propertyService;
  @protected
  @visibleForTesting
  static set firestore(FirebaseFirestore firestore) => _firestore = firestore;
}
