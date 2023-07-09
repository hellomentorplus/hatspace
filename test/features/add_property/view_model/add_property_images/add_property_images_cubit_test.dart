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

  tearDown(() {
    reset(permissionService);
  });

  group('requestPhotoPermission', () {
    blocTest(
      'given hs permission status is granted,'
      'when requestPhotoPermission,'
      'then return PhotoPermissionGranted',
      build: () => AddPropertyImagesCubit(),
      setUp: () {
        when(permissionService.checkPhotoPermission()).thenAnswer(
            (realInvocation) => Future.value(HsPermissionStatus.granted));
      },
      act: (bloc) => bloc.checkPhotoPermission(),
      expect: () => [isA<PhotoPermissionGranted>()],
    );

    blocTest(
      'given hs permission status is limited,'
      'when requestPhotoPermission,'
      'then return PhotoPermissionGranted',
      build: () => AddPropertyImagesCubit(),
      setUp: () {
        when(permissionService.checkPhotoPermission()).thenAnswer(
            (realInvocation) => Future.value(HsPermissionStatus.limited));
      },
      act: (bloc) => bloc.checkPhotoPermission(),
      expect: () => [isA<PhotoPermissionGranted>()],
    );

    blocTest(
      'given hs permission status is deniedForever,'
      'when requestPhotoPermission,'
      'then return PhotoPermissionDeniedForever',
      build: () => AddPropertyImagesCubit(),
      setUp: () {
        when(permissionService.checkPhotoPermission()).thenAnswer(
            (realInvocation) => Future.value(HsPermissionStatus.deniedForever));
      },
      act: (bloc) => bloc.checkPhotoPermission(),
      expect: () => [isA<PhotoPermissionDeniedForever>()],
    );

    blocTest(
      'given hs permission status is deniedForever,'
      'when requestPhotoPermission,'
      'then return PhotoPermissionDenied',
      build: () => AddPropertyImagesCubit(),
      setUp: () {
        when(permissionService.checkPhotoPermission()).thenAnswer(
            (realInvocation) => Future.value(HsPermissionStatus.denied));
      },
      act: (bloc) => bloc.checkPhotoPermission(),
      expect: () => [isA<PhotoPermissionDenied>()],
    );
  });

  group('dismissPhotoPermissionBottomSheet', () {
    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is true,'
      'when dismissPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(true),
      expect: () => [],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is false,'
      'when dismissPhotoPermissionBottomSheet,'
      'then return ClosePhotoPermissionBottomSheet',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(false),
      expect: () => [isA<ClosePhotoPermissionBottomSheet>()],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is false and state is OpenSettingScreen,'
      'when dismissPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => OpenSettingScreen(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(false),
      expect: () => [],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is null state is CancelPhotoAccess,'
      'when dismissPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => CancelPhotoAccess(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(false),
      expect: () => [],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is null,'
      'when dismissPhotoPermissionBottomSheet,'
      'then return ClosePhotoPermissionBottomSheet',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(null),
      expect: () => [isA<ClosePhotoPermissionBottomSheet>()],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is null and state is OpenSettingScreen,'
      'when dismissPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => OpenSettingScreen(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(null),
      expect: () => [],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is null state is CancelPhotoAccess,'
      'when dismissPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => CancelPhotoAccess(),
      act: (bloc) => bloc.dismissPhotoPermissionBottomSheet(null),
      expect: () => [],
    );
  });

  group('dismissPhotoPermissionBottomSheet', () {
    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is true,'
      'when dismissSelectPhotoPermissionBottomSheet,'
      'then do nothing',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissSelectPhotoPermissionBottomSheet(true),
      expect: () => [],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is false,'
      'when dismissSelectPhotoPermissionBottomSheet,'
      'then return CloseSelectPhotoBottomSheet',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissSelectPhotoPermissionBottomSheet(false),
      expect: () => [isA<CloseSelectPhotoBottomSheet>()],
    );

    blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
      'given isShown is null,'
      'when dismissSelectPhotoPermissionBottomSheet,'
      'then return CloseSelectPhotoBottomSheet',
      build: () => AddPropertyImagesCubit(),
      seed: () => PhotoPermissionDeniedForever(),
      act: (bloc) => bloc.dismissSelectPhotoPermissionBottomSheet(null),
      expect: () => [isA<CloseSelectPhotoBottomSheet>()],
    );
  });

  blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
    'when cancelPhotoAccess,'
    'then return CancelPhotoAccess',
    build: () => AddPropertyImagesCubit(),
    act: (bloc) => bloc.cancelPhotoAccess(),
    expect: () => [isA<CancelPhotoAccess>()],
  );

  blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
    'when openSelectPhotoBottomSheet,'
    'then return OpenSelectPhotoScreen',
    build: () => AddPropertyImagesCubit(),
    act: (bloc) => bloc.openSelectPhotoBottomSheet(),
    expect: () => [isA<OpenSelectPhotoScreen>()],
  );

  blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
    'when screenResumed and the last state is not OpenSettingScreen,'
    'then do nothing',
    build: () => AddPropertyImagesCubit(),
    act: (bloc) => bloc.screenResumed(),
    expect: () => [],
  );

  blocTest<AddPropertyImagesCubit, AddPropertyImagesState>(
    'when screenResumed and the last state is OpenSettingScreen and photo permission is return granted,'
    'then PhotoPermissionGranted',
    build: () => AddPropertyImagesCubit(),
    setUp: () {
      when(permissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));
    },
    seed: () => OpenSettingScreen(),
    act: (bloc) => bloc.screenResumed(),
    verify: (_) {
      verify(permissionService.checkPhotoPermission()).called(1);
    },
    expect: () => [isA<PhotoPermissionGranted>()],
  );
}
