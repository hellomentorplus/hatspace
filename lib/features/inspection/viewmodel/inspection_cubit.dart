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

  void getUserRole() async {
    try {
      final UserDetail user = await _authenticationService.getCurrentUser();
      final List<Roles> roles =
          await _storageService.member.getUserRoles(user.uid);
      List<DisplayItem> items = [Header()];
      if (roles.contains(Roles.homeowner)) {
        /**
         * TODO: 
         * - delete comment 
         * - handle get user booked property list logic here
         * 
         */
        // items.add(HomeOwnerBookingItem(
        //   '1',
        //   'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
        //   'Green living space in Melbourne',
        //   PropertyTypes.apartment,
        //   4800,
        //   Currency.aud,
        //   'pw',
        //   AustraliaStates.vic,
        //   1,
        // ));
      } else {
        // tenant
        /**
         * TODO: 
         * - delete comment 
         * - handle get user booked property list logic here
         * 
         */
        // items.add(NumberOfInspectionItem(3));
        // items.add(TenantBookingItem(
        //   '1',
        //   'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
        //   'Green living space in Melbourne',
        //   PropertyTypes.apartment,
        //   4800,
        //   Currency.aud,
        //   'pw',
        //   AustraliaStates.vic,
        //   '09:00 AM - 10:00 AM - 15 Sep, 2023',
        //   'Yolo Tim',
        //   null,
        // ));
        // items.add(TenantBookingItem(
        //   '2',
        //   'https://exej2saedb8.exactdn.com/wp-content/uploads/2022/02/Screen-Shot-2022-02-04-at-2.28.40-PM.png?strip=all&lossy=1&ssl=1',
        //   'Black and white apartment in Sydney',
        //   PropertyTypes.apartment,
        //   8500,
        //   Currency.aud,
        //   'pw',
        //   AustraliaStates.nsw,
        //   '14:00 PM - 15:00 PM - 16 Sep, 2023',
        //   'Cyber James',
        //   null,
        // ));
        // items.add(TenantBookingItem(
        //   '3',
        //   'https://cdn-bnokp.nitrocdn.com/QNoeDwCprhACHQcnEmHgXDhDpbEOlRHH/assets/images/optimized/rev-a642abc/www.decorilla.com/online-decorating/wp-content/uploads/2020/08/Modern-Apartment-Decor-.jpg',
        //   'Fully-furnished house in Rouse Hill',
        //   PropertyTypes.house,
        //   1000,
        //   Currency.aud,
        //   'pw',
        //   AustraliaStates.vic,
        //   '18:00 PM - 19:00 PM - 18 Sep, 2023',
        //   'Maggie Bean',
        //   null,
        // ));
      }
      // Check if items only have header
      if (items.length == 1) {
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
      final Inspection? inspection =
          await _storageService.inspection.getInspectionById(inspectionId);
      final Property? property =
          await _storageService.property.getProperty(inspection!.propertyId);
      final UserDetail? user =
          await _storageService.member.getUserDetail(property!.ownerUid);
      emit(InspectionItem(inspection, property, user!));
    } catch (e) {
      emit(NoBookedInspection());
    }
  }
}
