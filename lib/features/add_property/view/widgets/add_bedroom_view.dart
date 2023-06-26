import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                  HatSpaceStrings.of(context).addBedroomViewInstructions,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
          ),
          _AddBedroomCounter(
              counter: bedroomCounter,
              text: HatSpaceStrings.of(context).bedroomText),
          _AddBedroomCounter(
              counter: bathRoomCounter,
              text: HatSpaceStrings.of(context).bathroomText),
          _AddBedroomCounter(
              counter: parkingCounter,
              text: HatSpaceStrings.of(context).parkingText),
        ],
      ),
    );
  }
}

class _AddBedroomCounter extends StatelessWidget {
  final ValueNotifier<int> counter;
  final String text;
  const _AddBedroomCounter(
      {required this.counter, required this.text, super.key});

  bool checkCounterAdded(int counter) {
    return counter > 0;
  }

  bool checkCounterMaxReached(int counter) {
    return counter == 10;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              return Row(
                children: [
                  RoundButton(
                      iconUrl: Assets.images.decrement,
                      onPressed: checkCounterAdded(value)
                          ? () => counter.value -= 1
                          : null),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '$value',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  RoundButton(
                      iconUrl: Assets.images.increment,
                      onPressed: checkCounterMaxReached(value)
                          ? null
                          : () => counter.value += 1),
                ],
              );
            },
            valueListenable: counter,
          ),
        ],
      ),
    );
  }
}