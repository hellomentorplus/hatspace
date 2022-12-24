import 'package:flutter/material.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import 'user_role_card_view.dart';

class ChoosingRolesView extends StatefulWidget {
  const ChoosingRolesView({Key? key}) : super(key: key);

  @override
  State<ChoosingRolesView> createState() => _ChoosingRolesState();
}

class _ChoosingRolesState extends State<ChoosingRolesView> {
  int totalNumberOfCheckedTextBoxes = 0;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          padding:
              const EdgeInsets.only(top: 33, left: 16, right: 16, bottom: 33),
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
                          return UserRoleCardView(
                            position: position,
                            onChanged: (selectRoleState) {
                              setState(() {
                                selectRoleState
                                    ? totalNumberOfCheckedTextBoxes++
                                    : totalNumberOfCheckedTextBoxes--;
                              });
                            },
                          );
                        }),
                  ],
                ),
                Expanded(child: Container()),
                PrimaryButton(
                  label: HatSpaceStrings.of(context).continueBtn.toString(),
                  onPressed: totalNumberOfCheckedTextBoxes > 0 ? () {} : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 33),
                  child: TextOnlyButton(
                    label: HatSpaceStrings.of(context).cancelBtn.toString(),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePageView()));
                    },
                  ),
                ),
              ]),
        ));
  }
}
