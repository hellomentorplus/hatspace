import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/inspection/viewmodel/display_item.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

import 'package:hatspace/data/data.dart';

part 'inspection_state.dart';

class InspectionCubit extends Cubit<InspectionState> {
  InspectionCubit() : super(InspectionInitial());

  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final int thresholdValue = 3;
  void getUserRole() async {
    try {
      final UserDetail user = await _authenticationService.getCurrentUser();
      final List<Roles> roles =
          await _storageService.member.getUserRoles(user.uid);
      final List<String> inspectionIdList =
          await _storageService.member.getInspectionList(user.uid);
      List<DisplayItem> items = [Header()];
      if (roles.length == 2) {
        // user contain both Homeowner and Tenant
        // TODO; Handler when user has two roles
        return emit(NoBookedInspection());
      }
      if (roles.contains(Roles.homeowner)) {
        // Homeowner role only
        // Get homeower properties
        int count = 0;
        final List<String> propertyIdList =
            await _storageService.member.getMemberProperties(user.uid);
        for (String pId in propertyIdList) {
          count++;
          Property? newProperty =
              await _storageService.property.getProperty(pId);
          if (newProperty != null) {
            final HomeOwnerBookingItem newItem = HomeOwnerBookingItem(
                newProperty.id!,
                newProperty.photos[0],
                newProperty.name,
                newProperty.type,
                newProperty.price.rentPrice,
                newProperty.price.currency,
                'pw', // TODO: HANDLING PW with business logic
                newProperty.address.state,
                newProperty.inspectionList.length);
            items.add(newItem);
            if (count == thresholdValue) {
              emit(InspectionLoaded(List<DisplayItem>.from(items)));
              count = 0;
            }
          }
        }
      } else {
        // tenant role only
        // Get inspection list
        Inspection? inspection;
        Property? property;
        UserDetail? userDetail;
        items.add(NumberOfInspectionItem(inspectionIdList.length));
        for (String inspectionId in inspectionIdList) {
          inspection =
              await _storageService.inspection.getInspectionById(inspectionId);
          if (inspection != null) {
            property = await _storageService.property
                .getProperty(inspection.propertyId);
            userDetail =
                await _storageService.member.getUserDetail(property!.ownerUid);
          }
          if (property != null) {
            items.add(TenantBookingItem(
                inspectionId,
                property.photos[0],
                property.name,
                property.type,
                property.price.rentPrice,
                property.price.currency,
                'pw',
                property.address.state,
                inspection!.getRentingTime(),
                userDetail!.displayName,
                inspection.status,
                userDetail.avatar));
          }
        }
      }
      // Check if items only have header
      if (inspectionIdList.isEmpty) {
        emit(NoBookedInspection());
      } else {
        emit(InspectionLoaded(items));
      }
    } catch (e) {
      emit(GetUserRolesFailed());
    }
  }

  void getInspection(String inspectionId) async {
    try {
      Inspection? inspection =
          await _storageService.inspection.getInspectionById(inspectionId);
      Property? property =
          await _storageService.property.getProperty(inspection!.propertyId);
      UserDetail? user =
          await _storageService.member.getUserDetail(property!.ownerUid);
      emit(InspectionItem(inspection, property, user!));
    } catch (e) {
      emit(NoBookedInspection());
    }
  }
}
