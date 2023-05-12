import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class AddBedroomCounter extends StatelessWidget {
  final ValueNotifier<int> counter;
  final String text;
  const AddBedroomCounter(
      {super.key, required this.counter, required this.text});

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
                      "$value",
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
