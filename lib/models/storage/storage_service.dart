import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hatspace/models/storage/inspection_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/models/storage/file_service/file_storage_service.dart';

class StorageService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;

  final MemberService _member = MemberService(_firestore);
  final PropertyService _propertyService = PropertyService(_firestore);
  final InspectionService _inspectionService = InspectionService(_firestore);
  final FileService _files = FileService(_storage);

  MemberService get member => _member;
  PropertyService get property => _propertyService;
  InspectionService get inspection => _inspectionService;
  FileService get files => _files;

  @protected
  @visibleForTesting
  static set firestore(FirebaseFirestore firestore) => _firestore = firestore;

  @protected
  @visibleForTesting
  static set storage(FirebaseStorage storage) => _storage = storage;
}
