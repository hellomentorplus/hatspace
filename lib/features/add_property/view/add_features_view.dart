import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

const EdgeInsets _kScreenPadding =
    EdgeInsets.symmetric(horizontal: HsDimens.lineheight16);

class AddFeaturesView extends StatefulWidget {
  const AddFeaturesView({super.key});

  @override
  State<AddFeaturesView> createState() => _AddFeaturesViewState();
}

class _AddFeaturesViewState extends State<AddFeaturesView> {
  final ValueNotifier<List<String>> selectedFeatures =
      ValueNotifier<List<String>>([]);

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
          height: HsDimens.lineheight24,
        ),
        Padding(
          padding: _kScreenPadding,
          child: Text(
            HatSpaceStrings.of(context).askFeaturesOwned,

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
              return GridView.count(
                childAspectRatio: 164 / 98,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                padding:
                    _kScreenPadding.copyWith(bottom: HsDimens.lineheight16),
                children: [
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).fridge,
                      iconSvgPath: Assets.icons.fridge,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).fridge)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).washingMachine,
                      iconSvgPath: Assets.icons.washingMachine,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures.contains(
                          HatSpaceStrings.of(context).washingMachine)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).swimmingPool,
                      iconSvgPath: Assets.icons.swimmingPool,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).swimmingPool)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).airConditioners,
                      iconSvgPath: Assets.icons.airConditioners,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures.contains(
                          HatSpaceStrings.of(context).airConditioners)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).electricStove,
                      iconSvgPath: Assets.icons.electricStove,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).electricStove)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).tv,
                      iconSvgPath: Assets.icons.tv,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).tv)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).wifi,
                      iconSvgPath: Assets.icons.wifi,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).wifi)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).securityCameras,
                      iconSvgPath: Assets.icons.securityCameras,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures.contains(
                          HatSpaceStrings.of(context).securityCameras)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).kitchen,
                      iconSvgPath: Assets.icons.kitchen,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).kitchen)),
                  FeatureItemView(
                      title: HatSpaceStrings.of(context).portableFans,
                      iconSvgPath: Assets.icons.portableFans,
                      onSelectionChanged: onSelected,
                      isSelected: selectedFeatures
                          .contains(HatSpaceStrings.of(context).portableFans)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void onSelected(String feature, bool isSelected) {
    final List<String> newSelectedFeatures = List.from(selectedFeatures.value);
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
  final String title;
  final String iconSvgPath;
  final Function(String value, bool isSelected)? onSelectionChanged;
  const FeatureItemView(
      {required this.title,
      required this.iconSvgPath,
      super.key,
      this.isSelected = false,
      this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HsDimens.lineheight8),
          border: Border.all(
              width: 2,
              color: isSelected ? HSColor.primary : HSColor.neutral2)),
      child: InkWell(
        onTap: () => onSelectionChanged?.call(title, isSelected),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(HsDimens.lineheight4),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(iconSvgPath),
                      ),
                    ),
                    const SizedBox(
                      height: HsDimens.lineheight12,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
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
                    right: HsDimens.lineheight8,
                    top: HsDimens.lineheight8,
                    child: SvgPicture.asset(Assets.icons.check))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
