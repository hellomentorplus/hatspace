import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'get_properties_state.dart';

class GetPropertiesCubit extends Cubit<GetPropertiesState> {
  final StorageService storageService =
      HsSingleton.singleton.get<StorageService>();
  GetPropertiesCubit() : super(const GetPropertiesInitialState());

  void getProperties() async {
    try {
      emit(const GettingPropertiesState());
      final List<Property>? properties =
          await storageService.property.getAllProperties();

      if (properties == null) {
        emit(const GetPropertiesSucceedState([]));
        return;
      }

      final List<PropertyItemData> data = [];

      for (Property property in properties) {
        // get property owner info
        final String displayName =
            await storageService.member.getMemberDisplayName(property.ownerUid);
        final String? avatar =
            await storageService.member.getMemberAvatar(property.ownerUid);

        final UserDetail user = UserDetail(
            uid: property.ownerUid, displayName: displayName, avatar: avatar);

        data.add(PropertyItemData.fromModels(property, user));
      }

      if (!isClosed) {
        emit(GetPropertiesSucceedState(data));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const GetPropertiesFailedState());
      }
    }
  }
}
