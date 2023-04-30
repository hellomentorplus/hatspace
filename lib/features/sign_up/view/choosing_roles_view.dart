import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import 'user_role_card_view.dart';

class ChoosingRolesView extends StatelessWidget {
  const ChoosingRolesView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseRoleViewBloc>(
      create: (context) => ChooseRoleViewBloc(),
      child: const ChoosingRoleViewBody(),
    );
  }
}

class ChoosingRoleViewBody extends StatelessWidget {
  final bool continueBtnEnabled = false;

  const ChoosingRoleViewBody({super.key});
  void _submitRoles(
      {required Set<Roles> listRoles, required BuildContext context}) {
    context.read<ChooseRoleViewBloc>().add(OnSubmitRoleEvent(listRoles));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<ChooseRoleViewBloc, ChooseRoleViewState>(
        listener: (context, state) {
      if (state is ChoosingRoleSuccessState) {
        context.pop();
      }
      if (state is ChoosingRoleFail) {
        // TODO: Implement failure scenario
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HSColor.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: HSColor.onSurface),
              onPressed: () => {},
            ),
            bottom: PreferredSize(
              preferredSize: Size(size.width, 0),
              child: LinearProgressIndicator(
                backgroundColor: HSColor.neutral2,
                color: HSColor.neutral6,
                value: 0.75,
                semanticsLabel:
                    HatSpaceStrings.of(context).linearProgressIndicator,
              ),
            ),
            title: Text(HatSpaceStrings.of(context).app_name),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 33, left: 16, right: 16, bottom: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        HatSpaceStrings.of(context).chooseUserRole,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          HatSpaceStrings.of(context).chooseUserRoleDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.only(top: 32),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int position) {
                            return UserRoleCardView(
                              position: position,
                            );
                          }),
                    ],
                  ),
                  Expanded(child: Container()),
                  PrimaryButton(
                    label: HatSpaceStrings.of(context).continueBtn,
                    onPressed: state is UserRoleSelectedListState
                        ? state.listRole.isNotEmpty
                            ? () {
                                _submitRoles(
                                    listRoles: state.listRole,
                                    context: context);
                              }
                            : null
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 33),
                    child: TextOnlyButton(
                      label: HatSpaceStrings.of(context).cancelBtn,
                      onPressed: () {
                        context.goToHome();
                      },
                    ),
                  ),
                ]),
          ));
    });
  }
}
