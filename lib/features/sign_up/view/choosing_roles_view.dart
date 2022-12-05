import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class UserRoleDetail {
  String roleName;
  String description;

  UserRoleDetail({required this.roleName, required this.description});
}

class ChoosingRolesView extends StatelessWidget {
  const ChoosingRolesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserRoleDetail> userRoles = [
      UserRoleDetail(
          roleName: HatSpaceStrings.of(context).tenant.toString(),
          description:
              HatSpaceStrings.of(context).tenantRoleDescription.toString()),
      UserRoleDetail(
          roleName: HatSpaceStrings.of(context).homeowner.toString(),
          description:
              HatSpaceStrings.of(context).homeownerRoleDescription.toString()),
    ];
    final Size size = MediaQuery.of(context).size;
    int selectedIndex = -1;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // Remove shadow from app bar background
          backgroundColor: HSColor.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {},
          ),

          bottom: PreferredSize(
            preferredSize: Size(size.width, 0),
            child: const LinearProgressIndicator(
              backgroundColor: HSColor.neutral2,
              color: HSColor.neutral6,
              value: 0.75,
              semanticsLabel: 'Linear progress indicator',
            ),
          ),
          title: Text(HatSpaceStrings.of(context).app_name),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 33, left: 16, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      HatSpaceStrings.of(context).chooseUserRole.toString(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        HatSpaceStrings.of(context)
                            .chooseUserRoleDescription
                            .toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    ListView.builder(
                        padding: const EdgeInsets.only(top: 32),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int position) {
                          return Card(
                              margin: const EdgeInsets.only(top: 16),
                              elevation: 6,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: HSColor.neutral5,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userRoles[position].roleName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(userRoles[position].description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                              ));
                        }),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 33),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrimaryButton(
                          label: HatSpaceStrings.of(context)
                              .continueBtn
                              .toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 33),
                          child: TextOnlyButton(
                            label: HatSpaceStrings.of(context)
                                .cancelBtn
                                .toString(),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ))
              ]),
        ));
  }
}
