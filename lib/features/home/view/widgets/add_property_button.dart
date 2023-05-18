import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../view_model/home_interaction_cubit.dart';

class AddPropertyButton extends StatelessWidget {
  const AddPropertyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: 48,
        height: 48,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              context.read<HomeInteractionCubit>().onAddPropertyPressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                Assets.icons.add,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      );
}
