import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/features/add_property/view/select_property_type.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view/choosing_roles_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:intl/intl.dart';

class AddPropertyPageView extends StatefulWidget {
  const AddPropertyPageView({super.key
  });



  @override
  State<AddPropertyPageView> createState() => _AddPropertyPageViewState();
}

class _AddPropertyPageViewState extends State<AddPropertyPageView> {
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true
  );
  int currentPage = 0;
  
  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
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
                    value: (currentPage+1)/3,
                    semanticsLabel:
                        HatSpaceStrings.of(context).linearProgressIndicator,
                  ),
                ),
                title: Text(HatSpaceStrings.of(context).app_name),
              ), 
              body:BlocProvider<AddPropertyBloc>(
      create: (context) => AddPropertyBloc(),
      child: Column(
        children: [
          Expanded(child: 
              PageView.builder(
                onPageChanged: (value) {
                   setState(() {
                     currentPage = value;
                   });
                },
                physics:const NeverScrollableScrollPhysics(),
                controller: pageController,
        itemBuilder: (context, index){
          switch (index) {
            case 0:
              return SelectPropertyTypeBody();
            case 1: 
              return ChoosingRolesView();
            case 2: 
              return HomePageView();
            default: SelectPropertyTypeBody();
          }
        },
          )
      ),
                     Align(
                      alignment: Alignment.bottomRight,
                      child:   Container(
                        key:const Key("bottom button"),
                        padding:const EdgeInsets.fromLTRB(16, 8, 16, 42),
                        decoration: const BoxDecoration(
                          border:  Border(top: BorderSide(color:Color(0xfff3f3f3)))
                        ),
                        child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HsBackButton(onPressed: (){
                            pageController.animateToPage(currentPage -1,  duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          },lable: "BACK", icon: SvgPicture.asset(Assets.images.leftArrow)),
                          HsNextButton(onPressed: (){
                            // TODO: Click next to go to next page
                            
                            // pageController.jumpToPage(1);
                            pageController.animateToPage(currentPage+1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          }, icon: SvgPicture.asset(Assets.images.rightArrow, color: Colors.white,), lable: "NEXT")
                        ],
                      ),
                      ),
                     )     
        ],
      )
       

    ));
  }
}
