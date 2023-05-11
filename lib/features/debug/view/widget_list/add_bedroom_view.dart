import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/hs_theme.dart';

class AddBedroomView extends StatefulWidget {
  const AddBedroomView({super.key});

  @override
  State<AddBedroomView> createState() => AddBedroomViewState();
}

class AddBedroomViewState extends State<AddBedroomView> {
  final ValueNotifier<int> bedroomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> bathRoomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> parkingCounter = ValueNotifier<int>(0);

  bool checkCounterAdded(int counter) {
    return counter > 0;
  }

  bool checkCounterMaxReached(int counter) {
    return counter == 10;
  }

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
            PrevButton(
              label: "Back",
              iconUrl: Assets.images.chevronLeft,
              onPressed: () {},
            ),
            AnimatedBuilder(
                animation: Listenable.merge(
                    [bedroomCounter, bathRoomCounter, parkingCounter]),
                builder: (context, child) {
                  return NextButton(
                    iconUrl: Assets.images.chevronRight,
                    label: "Next",
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
                    HatSpaceStrings.of(context)
                        .addBedroomViewInstructions
                        .toString(),
                    style: Theme.of(context).textTheme.displayLarge),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    HatSpaceStrings.of(context).bedroomText.toString(),
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return Row(
                        children: [
                          RoundButton(
                              iconUrl: Assets.images.decrement,
                              onPressed: checkCounterAdded(value)
                                  ? () => bedroomCounter.value -= 1
                                  : null),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "$value",
                              style: textTheme.titleMedium,
                            ),
                          ),
                          RoundButton(
                              iconUrl: Assets.images.increment,
                              onPressed: checkCounterMaxReached(value)
                                  ? null
                                  : () => bedroomCounter.value += 1),
                        ],
                      );
                    },
                    valueListenable: bedroomCounter,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    HatSpaceStrings.of(context).bathroomText.toString(),
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return Row(
                        children: [
                          RoundButton(
                              iconUrl: Assets.images.decrement,
                              onPressed: checkCounterAdded(value)
                                  ? () => bathRoomCounter.value -= 1
                                  : null),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "$value",
                              style: textTheme.titleMedium,
                            ),
                          ),
                          RoundButton(
                              iconUrl: Assets.images.increment,
                              onPressed: checkCounterMaxReached(value)
                                  ? null
                                  : () => bathRoomCounter.value += 1),
                        ],
                      );
                    },
                    valueListenable: bathRoomCounter,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    HatSpaceStrings.of(context).parkingText.toString(),
                    style: textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  ValueListenableBuilder<int>(
                    builder: (BuildContext context, int value, Widget? child) {
                      return Row(
                        children: [
                          RoundButton(
                              iconUrl: Assets.images.decrement,
                              onPressed: checkCounterAdded(value)
                                  ? () => parkingCounter.value -= 1
                                  : null),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "$value",
                              style: textTheme.titleMedium,
                            ),
                          ),
                          RoundButton(
                              iconUrl: Assets.images.increment,
                              onPressed: checkCounterMaxReached(value)
                                  ? null
                                  : () => parkingCounter.value += 1),
                        ],
                      );
                    },
                    valueListenable: parkingCounter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
