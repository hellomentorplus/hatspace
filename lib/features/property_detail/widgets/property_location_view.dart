part of '../property_detail_screen.dart';

class PropertyLocationView extends StatelessWidget {
  final String locationDetail;
  const PropertyLocationView({required this.locationDetail, super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(HsDimens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              HatSpaceStrings.current.location,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, color: HSColor.neutral9),
            ),
            const SizedBox(
              height: HsDimens.spacing8,
            ),
            Text(
              locationDetail,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: HSColor.neutral7),
            )
          ],
        ),
      );
}
