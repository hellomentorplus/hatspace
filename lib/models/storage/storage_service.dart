import 'package:flutter/foundation.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';

import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'member_service/file_storage_service.dart';

class StorageService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final MemberService _member = MemberService(_firestore);
  final PropertyService _propertyService = PropertyService(_firestore);
  final FileService _files = FileService();

  MemberService get member => _member;
  PropertyService get property => _propertyService;
  FileService get files => _files;

  @protected
  @visibleForTesting
  static set firestore(FirebaseFirestore firestore) => _firestore = firestore;
}
