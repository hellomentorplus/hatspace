import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_cubit.dart';
import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/data/data.dart';

class UserRoleCardView extends StatelessWidget {
  final Roles role;
  const UserRoleCardView({required this.role, super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
        buildWhen: (prev, curr) => curr is ChoosingRoleState,
        builder: (context, state) {
          final bool isSelected =
              state is ChoosingRoleState && state.roles.contains(role);
          return InkWell(
              onTap: () => _onTapped.call(context),
              child: Card(
                  margin: EdgeInsets.zero,
                  color: isSelected ? HSColor.accent : HSColor.neutral2,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.5,
                        color:
                            isSelected ? HSColor.primary : Colors.transparent),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(HsDimens.radius8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(HsDimens.spacing16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(role.iconSvgPath),
                            const Spacer(),
                            SizedBox(
                              width: HsDimens.size24,
                              height: HsDimens.size24,
                              child: Checkbox(
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: HsDimens.size2,
                                        color: isSelected
                                            ? HSColor.primary
                                            : HSColor.neutral4),
                                  ),
                                  activeColor: HSColor.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          HsDimens.radius2)),
                                  value: isSelected,
                                  onChanged: (_) => _onTapped.call(context)),
                            )
                          ],
                        ),
                        const SizedBox(height: HsDimens.spacing16),
                        Text(
                          role.title,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontStyleGuide.fwBold,
                                  ),
                        ),
                        const SizedBox(height: HsDimens.spacing4),
                        Text(role.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: HSColor.neutral6))
                      ],
                    ),
                  )));
        });
  }

  void _onTapped(BuildContext context) {
    context.read<ChooseRoleCubit>().changeRole(role);
  }
}
