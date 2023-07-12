import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_cubit.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import 'package:hatspace/features/sign_up/view/widgets/user_role_card_view.dart';

class ChoosingRolesView extends StatelessWidget {
  const ChoosingRolesView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseRoleCubit>(
      create: (context) => ChooseRoleCubit(),
      child: const ChoosingRoleViewBody(),
    );
  }
}

class ChoosingRoleViewBody extends StatelessWidget {
  const ChoosingRoleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChooseRoleCubit, ChooseRoleState>(
      listener: (context, state) {
        if (state is SubmitRoleSucceedState) {
          context.goToHome();
        }
        if (state is SubmitRoleFailedState) {
          // TODO: Implement failure scenario
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.goToHome();
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: HSColor.background,
              actions: [
                Container(
                    margin: const EdgeInsets.only(right: HsDimens.spacing8),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: HSColor.onSurface),
                      onPressed: () => context.goToHome(),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  top: HsDimens.spacing8,
                  left: HsDimens.spacing24,
                  right: HsDimens.spacing24,
                  bottom: HsDimens.spacing44),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      HatSpaceStrings.current.chooseUserRole,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: HsDimens.spacing8),
                      child: Text(
                        HatSpaceStrings.current.chooseUserRoleDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                        child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: HsDimens.spacing32),
                      itemCount: Roles.values.length,
                      itemBuilder: (BuildContext context, int position) {
                        return UserRoleCardView(
                          key: ValueKey(Roles.values[position]),
                          role: Roles.values[position],
                        );
                      },
                      separatorBuilder: (_, ___) => const SizedBox(
                        height: HsDimens.spacing16,
                      ),
                    )),
                    BlocBuilder<ChooseRoleCubit, ChooseRoleState>(
                      builder: (innerCtx, state) {
                        final bool enabled = state is SubmitRoleFailedState ||
                            (state is ChoosingRoleState &&
                                state.roles.isNotEmpty);
                        return PrimaryButton(
                          label: HatSpaceStrings.current.signUp,
                          onPressed: enabled
                            ? () {
                                context
                                    .read<ChooseRoleCubit>()
                                    .submitUserRoles();
                              }
                            : null);
                      },
                    )
                  ]),
            )),
      ),
    );
  }
}
