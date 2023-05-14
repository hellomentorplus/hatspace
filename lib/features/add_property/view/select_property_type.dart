import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_bloc.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_event.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_view_state.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:intl/intl.dart';


class SelectPropertyType extends StatelessWidget {
  const SelectPropertyType({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseRoleViewBloc>(
      create: (context) => ChooseRoleViewBloc(),
      child: const SelectPropertyTypeBody(),
    );
  }
}

class SelectPropertyTypeBody extends StatelessWidget {
  const SelectPropertyTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String currentDate = DateFormat("dd MMMM, yyyy").format(DateTime.now());
    return BlocConsumer<ChooseRoleViewBloc, ChooseRoleViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: HSColor.background,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: HSColor.onSurface),
                  onPressed: () => {
                    //TODO; Implement bottom sheet warning
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: Size(size.width, 0),
                  child: LinearProgressIndicator(
                    backgroundColor: HSColor.neutral2,
                    color: HSColor.primary,
                    value: 0.75,
                    semanticsLabel:
                        HatSpaceStrings.of(context).linearProgressIndicator,
                  ),
                ),
                title: Text(HatSpaceStrings.of(context).app_name),
              ),
              body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 33, 16, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(HatSpaceStrings.of(context).selectingRoleScreenTitle,
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: 24,
                              color: HSColor.onSurface,
                              fontWeight: FontWeight.w700
                            )),
                            Container(height: 16),
                            Text(HatSpaceStrings.of(context).selectigRoleScreenSubtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            )),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 32),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                              ),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int position){
                                return PropertyTypeCartView(
                                  position: position,
                                );
                              }),
                            Container(height: 20),
                            Text(HatSpaceStrings.of(context).availableDate,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: HSColor.onSurface
                              ),
                            ),
                            Container(height: 4),
                                         OutlinedButton(
                          onPressed: () {
                            //
                          },
                          style: ButtonStyle(
                              textStyle: MaterialStatePropertyAll(textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
                              alignment: Alignment.center,
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              side: const MaterialStatePropertyAll<BorderSide>(
                                  BorderSide(color: HSColor.neutral3)),
                              backgroundColor: 
                               const MaterialStatePropertyAll<Color>(Colors.transparent),
                              foregroundColor: const MaterialStatePropertyAll<Color>(HSColor.neutral6)
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               Expanded(
                                child: Text(currentDate.isEmpty? "Unvailable":currentDate),
                              ),
                              SvgPicture.asset(Assets.images.calendar,width: 24,height: 24,)
                            ],
                          )),
                          ],
                        ) ,
                      ),
                      Container(
                        key:const Key("bottom button"),
                        padding:const EdgeInsets.fromLTRB(16, 8, 16, 42),
                        decoration: const BoxDecoration(
                          border:  Border(top: BorderSide(color:Color(0xfff3f3f3)))
                        ),
                        child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HsBackButton(lable: "BACK", icon: SvgPicture.asset(Assets.images.leftArrow)),
                          HsNextButton(icon: SvgPicture.asset(Assets.images.rightArrow, color: Colors.white,), lable: "NEXT")
                        ],
                      ),
                      )
                     
                    ]),
              );
        });
  }
}
