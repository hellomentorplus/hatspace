import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';

import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/data/property_data.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(HatSpaceStrings.current.inspectionBooking,
              style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(
            height: HsDimens.spacing20,
          ),
          Text(
            '3 inspect booking',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: FontStyleGuide.fontSize16,
                fontWeight: FontWeight.w500),
          ),
          TenantBookItemView(),
          // TenantBookItemView(),
          // TenantBookItemView(),
        ],
      ),
    );
  }
}

class TenantBookItemView extends StatelessWidget {
  const TenantBookItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: HsDimens.spacing12),
      child: Card(
        elevation: 5, // Controls the shadow depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(HsDimens.radius8),
                    child: Image.network(
                      'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                      width: HsDimens.size110,
                      height: HsDimens.size110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: HsDimens.spacing16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'House',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(
                            height: HsDimens.spacing5,
                          ),
                          Text('Single room for rent in Bankstown',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontStyleGuide.fwBold,
                                  )),
                          const SizedBox(
                            height: HsDimens.spacing5,
                          ),
                          Text('Gateway, Island',
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(
                            height: HsDimens.spacing4,
                          ),
                          Text.rich(TextSpan(
                              text: HatSpaceStrings.current
                                  .currencyFormatter(Currency.aud.symbol, 1200),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: FontStyleGuide.fontSize18,
                                      height: 28 / 18,
                                      fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                    text: ' pw',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: HSColor.neutral6))
                              ])),;
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: HsDimens.spacing12),
                child: Divider(),
              ),
              Text('09:AM - 10:00 AM - 14 Mar, 2023')
            ],
          ),
        ),
      ),
    );
  }
}
