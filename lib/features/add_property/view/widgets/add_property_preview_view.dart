import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/preview/add_property_preview_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddPropertyPreviewView extends StatelessWidget {
  const AddPropertyPreviewView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AddPropertyPreviewCubit(
          type: context.read<AddPropertyCubit>().propertyType,
          availableDate: context.read<AddPropertyCubit>().availableDate,
          ausState: context.read<AddPropertyCubit>().australiaState,
          rentPeriod: context.read<AddPropertyCubit>().rentPeriod,
          propertyName: context.read<AddPropertyCubit>().propertyName,
          price: context.read<AddPropertyCubit>().price,
          suburb: context.read<AddPropertyCubit>().suburb,
          postalCode: context.read<AddPropertyCubit>().postalCode,
          unitNumber: context.read<AddPropertyCubit>().unitNumber,
          address: context.read<AddPropertyCubit>().address,
          description: context.read<AddPropertyCubit>().description,
          bedrooms: context.read<AddPropertyCubit>().bedrooms,
          bathrooms: context.read<AddPropertyCubit>().bathrooms,
          parking: context.read<AddPropertyCubit>().parking,
          features: context.read<AddPropertyCubit>().features,
          photos: context.read<AddPropertyCubit>().photos,
        ),
        child: const AddPropertyPreviewBody(),
      );
}

class AddPropertyPreviewBody extends StatelessWidget {
  const AddPropertyPreviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: HsDimens.spacing24),
            Text(
              HatSpaceStrings.current.preview,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: HsDimens.spacing20),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                List<String>>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return state.photos;
                }
                return [];
              },
              builder: (context, photos) => _PropertyImgsCarousel(
                photos: photos,
              ),
            ),
            const SizedBox(height: HsDimens.spacing20),
            Row(
              children: [
                Expanded(
                    child: BlocSelector<AddPropertyPreviewCubit,
                        AddPropertyPreviewState, String>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.type.displayName;
                    }
                    return '';
                  },
                  builder: (context, type) {
                    return Text(type,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: HSColor.green06));
                  },
                )),
                const SizedBox(width: HsDimens.spacing12),
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    String>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return HatSpaceStrings.current
                          .dateFormatter(state.availableDate);
                    }

                    return '';
                  },
                  builder: (context, availableDate) {
                    return RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                            text: HatSpaceStrings.current.availableDateColon,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: HSColor.neutral6),
                            children: [
                              TextSpan(
                                text: availableDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: HSColor.neutral8,
                                    ),
                              )
                            ]));
                  },
                ),
              ],
            ),
            const SizedBox(height: HsDimens.spacing4),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                String>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return state.propertyName;
                }
                return '';
              },
              builder: (context, propertyName) {
                return Text(
                  propertyName,
                  style: Theme.of(context).textTheme.displayLarge,
                );
              },
            ),
            const SizedBox(height: HsDimens.spacing4),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                String>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return state.ausState.displayName;
                }
                return '';
              },
              builder: (context, suburb) {
                return Text(suburb,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: HSColor.neutral6));
              },
            ),
            const SizedBox(height: HsDimens.spacing8),
            Row(
              children: [
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    int>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.bedrooms;
                    }
                    return 0;
                  },
                  builder: (context, bedrooms) {
                    return _PropertyFeatureView(
                      iconSvgUrl: Assets.icons.bed,
                      quantity: bedrooms,
                    );
                  },
                ),
                const SizedBox(width: HsDimens.spacing8),
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    int>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.bathrooms;
                    }
                    return 0;
                  },
                  builder: (context, bathrooms) {
                    return _PropertyFeatureView(
                      iconSvgUrl: Assets.icons.bath,
                      quantity: bathrooms,
                    );
                  },
                ),
                const SizedBox(width: HsDimens.spacing8),
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    int>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.parking;
                    }
                    return 0;
                  },
                  builder: (context, parking) {
                    return _PropertyFeatureView(
                      iconSvgUrl: Assets.icons.car,
                      quantity: parking,
                    );
                  },
                ),
                const SizedBox(width: HsDimens.spacing12),
                Expanded(
                    child: BlocSelector<AddPropertyPreviewCubit,
                        AddPropertyPreviewState, double>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.price;
                    }
                    return 0.0;
                  },
                  builder: (context, price) {
                    return RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            text: HatSpaceStrings.current
                                .currencyFormatter(r'$', price),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: FontStyleGuide.fontSize18),
                            children: [
                              TextSpan(
                                text: ' ${HatSpaceStrings.current.pw}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontStyleGuide.fwRegular),
                              )
                            ]));
                  },
                ))
              ],
            ),
            const SizedBox(height: HsDimens.spacing16),
            Row(
              children: [
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    String?>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.userPhoto;
                    }

                    return null;
                  },
                  builder: (context, photoLink) => CircleAvatar(
                    radius: HsDimens.spacing20,
                    backgroundImage: photoLink?.isNotEmpty == true
                        ? NetworkImage(photoLink!)
                        : null,
                  ),
                ),
                const SizedBox(width: HsDimens.spacing8),
                BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                    String>(
                  selector: (state) {
                    if (state is AddPropertyPreviewReady) {
                      return state.userDisplayName ?? '';
                    }

                    return '';
                  },
                  builder: (context, displayName) {
                    return Expanded(
                      child: Text(displayName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6)),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: HsDimens.spacing8),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                String>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return state.description;
                }

                return '';
              },
              builder: (context, description) {
                return Text(description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: HSColor.neutral7));
              },
            ),
            const SizedBox(height: HsDimens.spacing20),
            const Divider(
              height: HsDimens.size4,
              thickness: HsDimens.size4,
              color: HSColor.neutral2,
            ),
            const SizedBox(height: HsDimens.spacing20),
            Text(HatSpaceStrings.current.location,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
            const SizedBox(height: HsDimens.spacing8),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                String>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return '${state.unitNumber.isEmpty ? '' : '${state.unitNumber}, '}${state.address}, ${state.suburb}, ${state.ausState.displayName} ${state.postalCode}';
                }

                return '';
              },
              builder: (context, fullAddress) {
                return Text(fullAddress,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: HSColor.neutral7));
              },
            ),
            BlocSelector<AddPropertyPreviewCubit, AddPropertyPreviewState,
                List<Feature>>(
              selector: (state) {
                if (state is AddPropertyPreviewReady) {
                  return state.features;
                }

                return [];
              },
              builder: (context, features) {
                if (features.isEmpty) {
                  return const SizedBox();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: HsDimens.spacing20),
                    const Divider(
                      height: HsDimens.size4,
                      thickness: HsDimens.size4,
                      color: HSColor.neutral2,
                    ),
                    const SizedBox(height: HsDimens.spacing20),
                    Text(HatSpaceStrings.current.propertyFeatures,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
                    const SizedBox(height: HsDimens.spacing16),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 164 / 36,
                                crossAxisSpacing: HsDimens.spacing15,
                                mainAxisSpacing: HsDimens.spacing12),
                        itemCount: features.length,
                        itemBuilder: (_, index) => Row(
                              children: [
                                Container(
                                  height: HsDimens.size36,
                                  width: HsDimens.size36,
                                  padding:
                                      const EdgeInsets.all(HsDimens.spacing8),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HSColor.neutral2),
                                  child: SvgPicture.asset(
                                      features[index].iconSvgPath),
                                ),
                                const SizedBox(width: HsDimens.spacing12),
                                Expanded(
                                    child: Text(features[index].displayName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium))
                              ],
                            ))
                  ],
                );
              },
            ),
            const SizedBox(height: HsDimens.spacing24),
          ]),
        ),
      ),
    );
  }
}

class _PropertyFeatureView extends StatelessWidget {
  final String iconSvgUrl;
  final int quantity;
  const _PropertyFeatureView(
      {required this.iconSvgUrl, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconSvgUrl),
        const SizedBox(
          width: HsDimens.spacing4,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }
}

class _PropertyImgsCarousel extends StatefulWidget {
  final List<String> photos;
  const _PropertyImgsCarousel({required this.photos});

  @override
  State<_PropertyImgsCarousel> createState() => __PropertyImgsCarouselState();
}

class __PropertyImgsCarouselState extends State<_PropertyImgsCarousel> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _idxNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _idxNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 220,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HsDimens.radius8),
        ),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.photos.length,
              onPageChanged: (index) => _idxNotifier.value = index,
              controller: _controller,
              itemBuilder: (_, int idx) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(HsDimens.radius8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(widget.photos[idx]),
                        ))),
              ),
            ),
            Positioned(
                bottom: HsDimens.spacing16,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: HsDimens.radius2,
                      right: HsDimens.radius2,
                      bottom: HsDimens.radius2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.photos
                            .map((photo) => ValueListenableBuilder<int>(
                                valueListenable: _idxNotifier,
                                builder: (_, selectedIndex, __) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: widget.photos.indexOf(photo) ==
                                                widget.photos.length - 1
                                            ? 0
                                            : HsDimens.spacing4),
                                    child: _DotIndicator(
                                      isSelected: selectedIndex ==
                                          widget.photos.indexOf(photo),
                                    ),
                                  );
                                }))
                            .toList(),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;
  const _DotIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HsDimens.size6,
      width: HsDimens.size6,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? HSColor.neutral1
              : HSColor.neutral1.withOpacity(0.5)),
    );
  }
}
