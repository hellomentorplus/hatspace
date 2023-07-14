import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/sign_up/choose_roles/view_model/choose_roles_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import 'package:hatspace/view_models/authentication/authentication_bloc.dart';

import 'package:hatspace/features/sign_up/choose_roles/view/widgets/user_role_card_view.dart';

class ChooseRolesScreen extends StatelessWidget {
  const ChooseRolesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseRolesCubit>(
      create: (context) => ChooseRolesCubit(),
      child: const ChooseRolesViewBody(),
    );
  }
}

class ChooseRolesViewBody extends StatelessWidget {
  const ChooseRolesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChooseRolesCubit, ChooseRolesState>(
      listener: (context, state) {
        if (state is SubmitRoleSucceedState) {
          context.pop();
        }
        if (state is SubmitRoleFailedState) {
          // TODO: Implement failure scenario
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          _cancelChoosingRoles(context);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: HSColor.background,
              actions: [
                GestureDetector(
                  onTap: () => _cancelChoosingRoles(context),
                  child: Container(
                      margin: const EdgeInsets.only(
                        top: HsDimens.spacing8,
                        bottom: HsDimens.spacing8,
                        right: HsDimens.spacing16,
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.close,
                        width: HsDimens.size32,
                        height: HsDimens.size32,
                      )),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
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
                      padding: const EdgeInsets.only(
                          top: HsDimens.spacing32, bottom: HsDimens.spacing20),
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
                    BlocBuilder<ChooseRolesCubit, ChooseRolesState>(
                      builder: (innerCtx, state) {
                        final bool enabled = state is SubmitRoleFailedState ||
                            (state is ChoosingRolesState &&
                                state.roles.isNotEmpty);
                        return PrimaryButton(
                            label: HatSpaceStrings.current.signUp,
                            onPressed: enabled
                                ? () {
                                    context
                                        .read<ChooseRolesCubit>()
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

  void _cancelChoosingRoles(BuildContext context) {
    context.read<AuthenticationBloc>().add(SkipSignUp());
    context.pop();
  }
}
