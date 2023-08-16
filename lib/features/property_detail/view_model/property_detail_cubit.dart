import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'property_detail_state.dart';

class PropertyDetailCubit extends Cubit<PropertyDetailState> {
  PropertyDetailCubit() : super(PropertyDetailInitial());

  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  void loadDetail(String id) async {
    final Property? property = await _storageService.property.getProperty(id);

    if (property == null) {
      emit(PropertyNotFound());
      return;
    }

    List<Feature> features = [];
    for (String s in property.additionalDetail.additional) {
      try {
        Feature feature =
            Feature.values.firstWhere((element) => element.name == s);

        features.add(feature);
      } catch (_) {
        // do nothing
      }
    }
    // get owner data
    final String ownerName =
        await _storageService.member.getMemberDisplayName(property.ownerUid);
    final String? ownerAvatar =
        await _storageService.member.getMemberAvatar(property.ownerUid);

    bool isOwned = false;
    try {
      final UserDetail userDetail =
          await _authenticationService.getCurrentUser();
      isOwned = userDetail.uid == property.ownerUid;
    } on UserNotFoundException catch (_) {
      // user is not logged in, do not allow to book
      isOwned = false;
    }

    emit(PropertyDetailLoaded(
        photos: property.photos,
        features: features,
        ownerName: ownerName,
        ownerAvatar: ownerAvatar,
        type: property.type.displayName,
        name: property.name,
        suburb: property.address.suburb,
        bedrooms: property.additionalDetail.bedrooms,
        bathrooms: property.additionalDetail.bathrooms,
        carspaces: property.additionalDetail.parkings,
        description: property.description,
        fullAddress: property.address.fullAddress,
        isOwned: isOwned,
        availableDate: property.availableDate.toDate(),
        price: property.price));
  }
}
