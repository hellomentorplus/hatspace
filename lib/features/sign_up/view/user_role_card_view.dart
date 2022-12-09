import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/sign_up/view/choosing_roles_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

// class UserRoleDetail {
//   String roleName;
//   String description;
//   bool isSelected;
//
//   UserRoleDetail(
//       {required this.roleName,
//       required this.description,
//       required this.isSelected});
// }

class UserRoleDetail {
  String title;
  String description;

  UserRoleDetail(this.title, this.description);
}
enum Roles { tenant, homeowner ;
  UserRoleDetail toUserRoleDetail(BuildContext context) {
    final String title = HatSpaceStrings.of(context).userRoles(name);
    final String description = HatSpaceStrings.of(context).tenantRoleDescription;

    return UserRoleDetail(title, description);
  }
}

class UserRoleCardView extends StatelessWidget {
  const UserRoleCardView({Key? key, required this.position}) : super(key: key);

  final int position;

  @override
  Widget build(BuildContext context) {

    UserRoleDetail userRoleDetail = Roles.values[position].toUserRoleDetail(context);

    return InkWell(
        onTap: () {

        },
        child: Card(
            margin: const EdgeInsets.only(top: 16),
            elevation: 6,
            color:
            // userRoles[position].isSelected == true
            //     ? HSColor.neutral5
            //     :
            HSColor.neutral1,
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
  }
}
