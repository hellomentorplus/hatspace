import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_appbar.dart';

class InspectionDetailScreen extends StatelessWidget {
  final String id;

  const InspectionDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<InspectionCubit>(
      create: (context) => InspectionCubit()..getInspection(id),
      child: InspectionDetailBody(
        id: id,
      ),
    );
  }
}

class InspectionDetailBody extends StatelessWidget {
  final String id;
  const InspectionDetailBody({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HsAppBar(
        title: HatSpaceStrings.current.details,
        // TODO : Enable later when implement deletion
        // actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset(
        //     Assets.icons.delete,
        //     colorFilter:
        //         const ColorFilter.mode(HSColor.red05, BlendMode.srcIn),
        //     width: HsDimens.size24,
        //     height: HsDimens.size24,
        //   ),
        // )
        // ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
              child: BlocBuilder<InspectionCubit, InspectionState>(
            builder: (context, state) {
              if (state is InspectionItem) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing16),
                    child: InspectionInformationView(
                        propertyImageUrl: state.property.photos[0],
                        propertyTitle: state.property.name,
                        propertyState: state.property.address.state.displayName,
                        propertyPrice: state.property.price.rentPrice,
                        propertySymbol: r'$',
                        type: state.property.type,
                        userName: state.userDetail.displayName ?? '',
                        userAvatar: state.userDetail.avatar,
                        startTime: state.inspection.startTime,
                        endTime: state.inspection.endTime,
                        notes: state.inspection.message,
                        rentingDuration: HatSpaceStrings.current.pw));
              }
              // TODO: Handler Widget when emit error state
              return const SizedBox.shrink();
            },
          )),
          // TODO : Enable later when implement edit feature
          // Positioned(
          //     bottom: 0,
          //     left: HsDimens.spacing16,
          //     right: HsDimens.spacing16,
          //     child: Container(
          //       padding: const EdgeInsets.only(
          //         top: HsDimens.spacing8,
          //         bottom: HsDimens.spacing42,
          //       ),
          //       decoration: const BoxDecoration(
          //           border: Border(
          //               top: BorderSide(
          //                   width: HsDimens.size1, color: HSColor.neutral2))),
          //       child: SecondaryButton(
          //         label: 'Edit',
          //         iconUrl: Assets.icons.edit,
          //         onPressed: () {
          //           // TODO : Handle on edit tapped
          //         },
          //       ),
          //     ))
        ],
      ),
    );
  }
}
