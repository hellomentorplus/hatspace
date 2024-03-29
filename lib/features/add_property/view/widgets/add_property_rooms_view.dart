import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class AddPropertyRoomsView extends StatefulWidget {
  const AddPropertyRoomsView({super.key});

  @override
  State<AddPropertyRoomsView> createState() => AddPropertyRoomsViewState();
}

class AddPropertyRoomsViewState extends State<AddPropertyRoomsView> {
  final ValueNotifier<int> bedroomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> bathRoomCounter = ValueNotifier<int>(0);
  final ValueNotifier<int> parkingCounter = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    bedroomCounter.value = context.read<AddPropertyCubit>().bedrooms;
    bathRoomCounter.value = context.read<AddPropertyCubit>().bathrooms;
    parkingCounter.value = context.read<AddPropertyCubit>().parking;

    bedroomCounter.addListener(() {
      context.read<AddPropertyCubit>().bedrooms = bedroomCounter.value;
    });

    bathRoomCounter.addListener(() {
      context.read<AddPropertyCubit>().bathrooms = bathRoomCounter.value;
    });

    parkingCounter.addListener(() {
      context.read<AddPropertyCubit>().parking = parkingCounter.value;
    });
  }

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
              child: Text(HatSpaceStrings.current.addBedroomViewInstructions,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
          ),
          _AddBedroomCounter(
              counter: bedroomCounter,
              text: HatSpaceStrings.current.bedroomText),
          _AddBedroomCounter(
              counter: bathRoomCounter,
              text: HatSpaceStrings.current.bathroomText),
          _AddBedroomCounter(
              counter: parkingCounter,
              text: HatSpaceStrings.current.parkingText),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bedroomCounter.dispose();
    bathRoomCounter.dispose();
    parkingCounter.dispose();
    super.dispose();
  }
}

class _AddBedroomCounter extends StatelessWidget {
  final ValueNotifier<int> counter;
  final String text;
  const _AddBedroomCounter({required this.counter, required this.text});

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
                      iconUrl: Assets.icons.decrement,
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
                      iconUrl: Assets.icons.increment,
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
