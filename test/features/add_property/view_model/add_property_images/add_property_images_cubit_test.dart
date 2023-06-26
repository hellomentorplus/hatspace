import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../view/widgets/add_property_images_view_test.mocks.dart';

@GenerateMocks([HsPermissionService])
void main() {
  final MockHsPermissionService permissionService = MockHsPermissionService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(permissionService);
  });

  blocTest(
    'given hs permission status is granted,'
    'when requestPhotoPermission,'
    'then return PhotoPermissionGranted',
    build: () => AddPropertyImagesCubit(),
    setUp: () {
      when(permissionService.requestPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));
    },
    act: (bloc) => bloc.requestPhotoPermission(),
    expect: () => [isA<PhotoPermissionGranted>()],
    tearDown: () => reset(permissionService),
  );

  blocTest(
    'given hs permission status is limited,'
    'when requestPhotoPermission,'
    'then return PhotoPermissionGranted',
    build: () => AddPropertyImagesCubit(),
    setUp: () {
      when(permissionService.requestPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.limited));
    },
    act: (bloc) => bloc.requestPhotoPermission(),
    expect: () => [isA<PhotoPermissionGranted>()],
    tearDown: () => reset(permissionService),
  );

  blocTest(
    'given hs permission status is deniedForever,'
    'when requestPhotoPermission,'
    'then return PhotoPermissionDeniedForever',
    build: () => AddPropertyImagesCubit(),
    setUp: () {
      when(permissionService.requestPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.deniedForever));
    },
    act: (bloc) => bloc.requestPhotoPermission(),
    expect: () => [isA<PhotoPermissionDeniedForever>()],
    tearDown: () => reset(permissionService),
  );

  blocTest(
    'given hs permission status is deniedForever,'
    'when requestPhotoPermission,'
    'then return PhotoPermissionDenied',
    build: () => AddPropertyImagesCubit(),
    setUp: () {
      when(permissionService.requestPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.denied));
    },
    act: (bloc) => bloc.requestPhotoPermission(),
    expect: () => [isA<PhotoPermissionDenied>()],
    tearDown: () => reset(permissionService),
  );
}
