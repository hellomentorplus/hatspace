import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_cubit.dart';
import 'package:hatspace/features/property_detail/widgets/property_description_view.dart';
import 'package:hatspace/features/property_detail/widgets/property_features_view.dart';
import 'package:hatspace/features/property_detail/widgets/property_location_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_property_images_carousel.dart';
import 'package:hatspace/theme/widgets/hs_room_count_view.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';

class RoomsCount {
  final int bedrooms;
  final int bathrooms;
  final int cars;

  RoomsCount(
      {required this.bedrooms, required this.bathrooms, required this.cars});
}

class PropertyDetailScreen extends StatelessWidget {
  final String id;
  const PropertyDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<PropertyDetailCubit>(
        create: (context) => PropertyDetailCubit()..loadDetail(id),
        child: const PropertyDetailBody(), 
      );
}

class PropertyDetailBody extends StatelessWidget {
  const PropertyDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  BlocSelector<PropertyDetailCubit, PropertyDetailState,
                      List<String>>(
                    selector: (state) {
                      if (state is PropertyDetailLoaded) {
                        return state.photos;
                      }
                      return [];
                    },
                    builder: (context, photos) => HsPropertyImagesCarousel(
                      photos: photos,
                      ownerAndDateOverlay: false,
                      aspectRatio: 375 / 280,
                    ),
                  ),
                  SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: HsDimens.spacing16,
                        horizontal: HsDimens.spacing8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset(
                            Assets.icons.backCircle,
                            width: HsDimens.size32,
                            height: HsDimens.size32,
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.icons.favoriteCircle,
                          width: HsDimens.size32,
                          height: HsDimens.size32,
                        )
                      ],
                    ),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: HsDimens.spacing16,
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocSelector<PropertyDetailCubit, PropertyDetailState,
                        String>(
                      selector: (state) {
                        if (state is PropertyDetailLoaded) {
                          return state.type;
                        }
                        return '';
                      },
                      builder: (context, type) {
                        return Text(
                          type,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.eye,
                          width: HsDimens.size24,
                          height: HsDimens.size24,
                        ),
                        const SizedBox(
                          width: HsDimens.size4,
                        ),
                        Text(
                          // TODO implement view count
                          HatSpaceStrings.current.viewsToday(0),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing4),
                child: BlocSelector<PropertyDetailCubit, PropertyDetailState,
                    String>(
                  selector: (state) {
                    if (state is PropertyDetailLoaded) {
                      return state.name;
                    }

                    return '';
                  },
                  builder: (context, propertyName) {
                    return Text(
                      propertyName,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: HSColor.neutral9),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing8),
                child: BlocSelector<PropertyDetailCubit, PropertyDetailState,
                    String>(
                  selector: (state) {
                    if (state is PropertyDetailLoaded) {
                      return state.suburb;
                    }
                    return '';
                  },
                  builder: (context, suburb) {
                    return Text(
                      suburb,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: HSColor.neutral6),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing16),
                child: BlocSelector<PropertyDetailCubit, PropertyDetailState,
                    RoomsCount>(
                  selector: (state) {
                    if (state is PropertyDetailLoaded) {
                      return RoomsCount(
                          bedrooms: state.bedrooms,
                          bathrooms: state.bathrooms,
                          cars: state.carspaces);
                    }

                    return RoomsCount(cars: 0, bedrooms: 0, bathrooms: 0);
                  },
                  builder: (context, rooms) {
                    return RoomListingCountView(
                      bedrooms: rooms.bedrooms,
                      bathrooms: rooms.bathrooms,
                      cars: rooms.cars,
                    );
                  },
                ),
              ),
              // owner info
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing16),
                child: Row(
                  children: [
                    BlocSelector<PropertyDetailCubit, PropertyDetailState,
                        String?>(
                      selector: (state) {
                        if (state is PropertyDetailLoaded) {
                          return state.ownerAvatar;
                        }

                        return null;
                      },
                      builder: (context, avatar) {
                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(HsDimens.radius24),
                          // TODO what to show when avatar is null?
                          child: avatar == null
                              ? const SizedBox()
                              : CachedNetworkImage(
                                  imageUrl: avatar,
                                  width: HsDimens.size24,
                                  height: HsDimens.size24,
                                ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: HsDimens.spacing8,
                    ),
                    BlocSelector<PropertyDetailCubit, PropertyDetailState,
                        String>(
                      selector: (state) {
                        if (state is PropertyDetailLoaded) {
                          return state.ownerName;
                        }

                        return '';
                      },
                      builder: (context, ownerName) {
                        return Text(
                          ownerName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing8),
                child: BlocSelector<PropertyDetailCubit, PropertyDetailState,
                    String>(
                  selector: (state) {
                    if (state is PropertyDetailLoaded) {
                      return state.description;
                    }
                    return '';
                  },
                  builder: (context, description) {
                    return PropertyDescriptionView(
                      description: description,
                      maxLine: 3,
                    );
                  },
                ),
              ),
              const Divider(
                height: HsDimens.size4,
                thickness: HsDimens.size4,
                color: HSColor.neutral2,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticatedState) {
                    return BlocSelector<PropertyDetailCubit,
                        PropertyDetailState, String>(
                      selector: (state) {
                        if (state is PropertyDetailLoaded) {
                          return state.fullAddress;
                        }
                        return '';
                      },
                      builder: (context, address) => PropertyLocationView(
                        locationDetail: address,
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
              const Divider(
                height: HsDimens.size4,
                thickness: HsDimens.size4,
                color: HSColor.neutral2,
              ),
              BlocSelector<PropertyDetailCubit, PropertyDetailState,
                  List<Feature>>(
                selector: (state) {
                  if (state is PropertyDetailLoaded) {
                    return state.features;
                  }

                  return [];
                },
                builder: (context, features) {
                  return PropertyFeaturesView(features: features);
                },
              )
            ],
          ),
        ),
      );
}
