import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_counter.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

import '../../../gen/assets.gen.dart';
import '../../../theme/hs_theme.dart';

class AddBedroomView extends StatefulWidget {
  const AddBedroomView({super.key});

  @override
  State<AddBedroomView> createState() => AddBedroomViewState();
}

class AddBedroomViewState extends State<AddBedroomView> {
  final ValueNotifier<int> bedroomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> bathRoomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> parkingCounter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove shadow from app bar background
        backgroundColor: HSColor.background,
        leading: Padding(
          padding: const EdgeInsets.only(top: 0, left: 10, right: 0),
          child: IconButton(
              icon: SvgPicture.asset(Assets.images.closeIcon),
              onPressed: () {} //TODO: Implement close button at later date
              ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: HSColor.background,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextOnlyButton(
              label: HatSpaceStrings.of(context).back,
              iconUrl: Assets.images.chevronLeft,
              contentAlignment: MainAxisAlignment.start,
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    //=====DISABLED EVENT
                    if (states.contains(MaterialState.disabled)) {
                      return HSColor.neutral5;
                    } else {
                      return HSColor.neutral9;
                    }
                  },
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(10, 17, 32, 17)),
              ),
            ),
            AnimatedBuilder(
                animation: Listenable.merge(
                    [bedroomCounter, bathRoomCounter, parkingCounter]),
                builder: (context, child) {
                  return PrimaryButton(
                    iconUrl: Assets.images.chevronRight,
                    label: HatSpaceStrings.of(context).next,
                    iconPosition: IconPosition.right,
                    contentAlignment: MainAxisAlignment.end,
                    onPressed: [
                      bedroomCounter.value,
                      parkingCounter.value,
                      bathRoomCounter.value
                    ].any((counter) => counter > 0)
                        ? () {}
                        : null,
                  );
                })
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              value: 0.5,
              color: HSColor.primary,
              backgroundColor: HSColor.neutral2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                    HatSpaceStrings.of(context).addBedroomViewInstructions,
                    style: Theme.of(context).textTheme.displayLarge),
              ),
            ),
            AddBedroomCounter(
                counter: bedroomCounter,
                text: HatSpaceStrings.of(context).bedroomText),
            AddBedroomCounter(
                counter: bathRoomCounter,
                text: HatSpaceStrings.of(context).bathroomText),
            AddBedroomCounter(
                counter: parkingCounter,
                text: HatSpaceStrings.of(context).parkingText),
          ],
        ),
      ),
    );
  }
}
