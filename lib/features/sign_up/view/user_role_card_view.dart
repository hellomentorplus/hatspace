import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class UserRoleDetail {
  String title;
  String description;

  UserRoleDetail(this.title, this.description);
}

enum Roles {
  tenant,
  homeowner;

  UserRoleDetail toUserRoleDetail(BuildContext context) {
    final String title = HatSpaceStrings.of(context).userTitleRoles(name);
    final String description =
        HatSpaceStrings.of(context).userRoleDescription(name);

    return UserRoleDetail(title, description);
  }
}

class UserRoleCardView extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const UserRoleCardView(
      {Key? key, required this.position, required this.onChanged})
      : super(key: key);

  final int position;

  @override
  // ignore: library_private_types_in_public_api
  _UserRoleCardState createState() => _UserRoleCardState();
}

class _UserRoleCardState extends State<UserRoleCardView> {
  ValueNotifier<Set<int>> listenValue = ValueNotifier({});

  Widget build(BuildContext context) {
    UserRoleDetail userRoleDetail =
        Roles.values[widget.position].toUserRoleDetail(context);

    return InkWell(
        onTap: () {
          final bool selectRoleState;
          Set<int> cur = Set.of(listenValue.value);
          if (cur.contains(widget.position)) {
            cur.remove(widget.position);
            selectRoleState = false;
          } else {
            cur.add(widget.position);
            selectRoleState = true;
          }
          listenValue.value = cur;
          widget.onChanged(selectRoleState);
        },
        child: ValueListenableBuilder<Set<int>>(
          builder: (BuildContext context, Set<int> value, Widget? child) {
            return Card(
                margin: const EdgeInsets.only(top: 16),
                elevation: 6,
                color: value.contains(widget.position)
                    ? HSColor.neutral5
                    : HSColor.neutral1,
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
                ));
          },
          valueListenable: listenValue,
        ));
  }
}
