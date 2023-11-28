import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';

class AddPropertyButton extends StatelessWidget {
  const AddPropertyButton({super.key});

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
              context.read<DashboardInteractionCubit>().onAddPropertyPressed();
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
