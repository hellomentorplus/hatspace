import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddPropertyFeaturesView extends StatefulWidget {
  const AddPropertyFeaturesView({super.key});

  @override
  State<AddPropertyFeaturesView> createState() =>
      _AddPropertyFeaturesViewState();
}

class _AddPropertyFeaturesViewState extends State<AddPropertyFeaturesView> {
  final ValueNotifier<List<Feature>> selectedFeatures =
      ValueNotifier<List<Feature>>([]);

  @override
  void initState() {
    super.initState();

    selectedFeatures.value = context.read<AddPropertyCubit>().features;

    selectedFeatures.addListener(() {
      context.read<AddPropertyCubit>().features = selectedFeatures.value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    selectedFeatures.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: HsDimens.spacing24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
          child: Text(
            HatSpaceStrings.current.askFeaturesOwned,

            /// This one help preventing overflow when run flutter test
            maxLines: 3, overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: HSColor.neutral9),
          ),
        ),
        const SizedBox(
          height: HsDimens.spacing20,
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: selectedFeatures,
            builder: (_, selectedFeatures, __) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 164 / 98,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  padding: const EdgeInsets.only(
                      left: HsDimens.spacing16,
                      bottom: HsDimens.spacing16,
                      right: HsDimens.spacing16),
                  itemCount: Feature.values.length,
                  itemBuilder: (_, index) => FeatureItemView(
                      feature: Feature.values[index],
                      onSelectionChanged: onSelected,
                      isSelected:
                          selectedFeatures.contains(Feature.values[index])));
            },
          ),
        ),
      ],
    );
  }

  void onSelected(Feature feature, bool isSelected) {
    final List<Feature> newSelectedFeatures = List.from(selectedFeatures.value);
    if (isSelected) {
      newSelectedFeatures.remove(feature);
    } else {
      newSelectedFeatures.add(feature);
    }
    selectedFeatures.value = newSelectedFeatures;
  }
}

class FeatureItemView extends StatelessWidget {
  final bool isSelected;
  final Feature feature;
  final Function(Feature feature, bool isSelected)? onSelectionChanged;
  const FeatureItemView(
      {required this.feature,
      super.key,
      this.isSelected = false,
      this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HsDimens.spacing8),
          border: Border.all(
              width: 2,
              color: isSelected ? HSColor.primary : HSColor.neutral2)),
      child: InkWell(
        onTap: () => onSelectionChanged?.call(feature, isSelected),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(HsDimens.spacing8),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(feature.iconSvgPath),
                      ),
                    ),
                    const SizedBox(
                      height: HsDimens.spacing12,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        feature.displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: HSColor.neutral9),
                      ),
                    ))
                  ],
                ),
              ),
              if (isSelected) ...[
                Positioned(
                    right: HsDimens.spacing8,
                    top: HsDimens.spacing8,
                    child: SvgPicture.asset(Assets.icons.checkCircular))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
