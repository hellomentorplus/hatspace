import 'package:flutter/material.dart';
import 'package:hatspace/features/add_bedroom/view/add_bedroom_counter.dart';
import 'package:hatspace/strings/l10n.dart';

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
    );
  }
}
