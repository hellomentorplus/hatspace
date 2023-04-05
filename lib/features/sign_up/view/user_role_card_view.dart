import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view/choose_role_view_bloc.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../../../data/data.dart';

class UserRoleDetail {
  String title;
  String description;

  UserRoleDetail(this.title, this.description);
}

extension RoleToDetail on Roles {
  UserRoleDetail toUserRoleDetail(BuildContext context) {
    final String title = HatSpaceStrings.of(context).userTitleRoles(name);
    final String description =
        HatSpaceStrings.of(context).userRoleDescription(name);

    return UserRoleDetail(title, description);
  }
}
class UserRoleCardView extends StatelessWidget {
  final int position;
  const UserRoleCardView({super.key, required this.position});
  @override
  Widget build(BuildContext context) {
    UserRoleDetail userRoleDetail =
        Roles.values[position].toUserRoleDetail(context);

    return BlocBuilder<ChooseRoleViewBloc, ChooseRoleViewState>(
        builder: (context, state) {
      // print(state); ask Sue
      return InkWell(
          onTap: () {
            context
                .read<ChooseRoleViewBloc>()
                .add(OnChangeUserRoleEvent(position));
          },
          child: Card(
              margin: const EdgeInsets.only(top: 16),
              elevation: 6,
              color: state is UserRoleSelectedListState
                  ? state.listRole.contains(Roles.values[position])
                      ? HSColor.neutral5
                      : HSColor.neutral1
                  : null,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: HSColor.neutral5),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userRoleDetail.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(userRoleDetail.description,
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
              )));
    });
  }
}