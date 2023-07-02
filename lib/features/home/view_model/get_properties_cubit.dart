import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      final List<PropertyItemData> displayProperties = [];
      if (properties != null && properties.isNotEmpty) {
        for (Property prop in properties) {
          displayProperties.add(PropertyItemData.fromModel(
              prop,
              const User(
                id: '1232312312',
                name: 'Mock Owner',
                avatar:
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80')));
        }
      }

      emit(GetPropertiesSucceedState(displayProperties));
    } catch (_) {
      emit(const GetPropertiesFailedState('Failed to fetch properties'));
    }
  }
}
