import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/features/inspection_detail/widgets/property_card_view.dart';

class InspectionInformationView extends StatelessWidget {
  final String propertyImageUrl;
  final String propertyTitle;
  final String propertyState;
  final double propertyPrice;
  final String propertySymbol;
  final PropertyTypes type;
  final String? userAvatar;
  final String userName;
  final DateTime startTime;
  final DateTime endTime;
  final String notes;
  final String rentingDuration;
  const InspectionInformationView(
      {required this.propertyImageUrl,
      required this.propertyTitle,
      required this.propertyState,
      required this.propertyPrice,
      required this.propertySymbol,
      required this.type,
      required this.userName,
      required this.startTime,
      required this.endTime,
      required this.notes,
      required this.rentingDuration,
      this.userAvatar,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: HsDimens.spacing16),
        PropertyCardView(
          imageUrl: propertyImageUrl,
          type: type,
          title: propertyTitle,
          state: propertyState,
          price: propertyPrice,
          symbol: propertySymbol,
          rentingDuration: rentingDuration,
        ),
        const SizedBox(height: HsDimens.spacing20),
        const _Divider(),
        const SizedBox(height: HsDimens.spacing20),
        Row(
          children: [
            Container(
              width: HsDimens.size24,
              height: HsDimens.size24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: HSColor.neutral2,
              ),
              clipBehavior: Clip.hardEdge,
              child: userAvatar != null && userAvatar!.isNotEmpty
                  ? Image.network(
                      userAvatar!,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      Assets.images.userDefaultAvatar,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: HsDimens.spacing8),
            Expanded(
                child: Text(userName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500))),

            /// TODO : Enable later when implementing message and call feature
            // _RoundIconButton(
            //   iconPath: Assets.icons.message,
            //   onPressed: () {
            //     /// TODO : Handle on mesage tapped
            //   },
            // ),
            // const SizedBox(width: HsDimens.spacing20),
            // _RoundIconButton(
            //   iconPath: Assets.icons.phone,
            //   onPressed: () {
            //     /// TODO : Handle on call tapped
            //   },
            // ),
          ],
        ),
        const SizedBox(height: HsDimens.spacing20),
        const _Divider(),
        const SizedBox(height: HsDimens.spacing20),
        Row(
          children: [
            Expanded(
              child: _TimeInformationView(
                title: HatSpaceStrings.current.start,
                value: HatSpaceStrings.current.timeFormatter(startTime),
              ),
            ),
            const SizedBox(width: HsDimens.spacing15),
            Expanded(
              child: _TimeInformationView(
                title: HatSpaceStrings.current.end,
                value: HatSpaceStrings.current.timeFormatter(endTime),
              ),
            ),
            const SizedBox(width: HsDimens.spacing15),
            Expanded(
              child: _TimeInformationView(
                title: HatSpaceStrings.current.date,
                value: HatSpaceStrings.current.dateFormatterWithDate(endTime),
              ),
            ),
          ],
        ),
        const SizedBox(height: HsDimens.spacing20),
        const _Divider(),
        const SizedBox(height: HsDimens.spacing20),
        _TitleView(title: HatSpaceStrings.current.notes),
        const SizedBox(height: HsDimens.spacing4),
        Text(notes,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// TODO : Enable later when implementing message and call feature
// class _RoundIconButton extends StatelessWidget {
//   final String iconPath;
//   final VoidCallback onPressed;
//   const _RoundIconButton({required this.iconPath, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return RoundButton(
//       iconUrl: iconPath,
//       style: roundButtonTheme.style?.copyWith(
//           minimumSize: const MaterialStatePropertyAll<Size>(
//               Size(HsDimens.size40, HsDimens.size40)),
//           maximumSize: const MaterialStatePropertyAll<Size>(
//               Size(HsDimens.size40, HsDimens.size40)),
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
//               EdgeInsets.all(HsDimens.spacing8))),
//       onPressed: onPressed,
//     );
//   }
// }

class _TimeInformationView extends StatelessWidget {
  final String title;
  final String value;
  const _TimeInformationView({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleView(title: title),
        const SizedBox(height: HsDimens.spacing4),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _TitleView extends StatelessWidget {
  final String title;
  const _TitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.w500, color: HSColor.neutral5));
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
        color: HSColor.neutral2,
        thickness: HsDimens.size1,
        height: HsDimens.size1);
  }
}
