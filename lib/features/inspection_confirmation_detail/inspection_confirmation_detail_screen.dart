import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_appbar.dart';

class InspectionConfirmationDetailScreen extends StatelessWidget {
  final String id;
  const InspectionConfirmationDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HsAppBar(
        title: HatSpaceStrings.current.details,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
                child: InspectionInformationView(
                    propertyImageUrl:
                        'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                    propertyTitle: 'Green living space in Melbourne',
                    propertyPrice: 4800,
                    propertyState: 'Victoria',
                    propertySymbol: r'$',
                    userName: 'Captain Cole',
                    type: PropertyTypes.apartment,
                    startTime: DateTime(2023, 9, 15, 9),
                    endTime: DateTime(2023, 9, 15, 10),
                    rentingDuration: HatSpaceStrings.current.pw,
                    notes: '')),
          ),
        ],
      ),
    );
  }
}
