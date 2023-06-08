import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';

class PropertyTypeDetail {
  SvgPicture icon;
  String tilte;
  PropertyTypeDetail(this.icon, this.tilte);
}

class PropertyTypeCardView extends StatelessWidget {
  final int position;
  const PropertyTypeCardView({super.key, required this.position});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PropertyTypeCubit, PropertyTypeState, PropertyTypes?>(
        selector: (state) => state.propertyTypes,
        builder: (context, state) {
          Color cardColor;
          RoundedRectangleBorder cardShape;
          if (state == PropertyTypes.values[position]) {
            cardColor = const Color(0xFFEBFAEF);
            cardShape = const RoundedRectangleBorder(
                side: BorderSide(width: 1.5, color: Color(0xFF32A854)),
                borderRadius: BorderRadius.all(Radius.circular(8)));
          } else {
            cardColor = const Color(0xFFF3F3F3);
            cardShape = const RoundedRectangleBorder(
                side: BorderSide(width: 1.5, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(8)));
          }
          return InkWell(
              onTap: () {
                context
                    .read<PropertyTypeCubit>()
                    .selectPropertyTypeEvent(position);
              },
              child: AspectRatio(
                aspectRatio: 1,
                child: Card(
                    shadowColor: Colors.transparent,
                    margin: const EdgeInsets.only(top: 20),
                    elevation: 6,
                    color: cardColor,
                    shape: cardShape,
                    child: Padding(
                      padding: const EdgeInsets.all(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: SvgPicture.asset(
                            PropertyTypes.values[position].getIconPath(),
                          )),
                          const SizedBox(
                            height: 16,
                          ),
                          Expanded(
                              child: Text(
                                  PropertyTypes.values[position].name
                                      .toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w700)))
                        ],
                      ),
                    )),
              ));
        });
  }
}
