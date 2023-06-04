
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

class PropertyTypeCartView extends StatelessWidget {
  final int position;
  const PropertyTypeCartView({super.key, required this.position});
  @override
  Widget build(BuildContext context) {
    // print("render card");
    Color cardColor = const Color(0xFFF3F3F3);
    RoundedRectangleBorder cardShape = const RoundedRectangleBorder(
        side: BorderSide(width: 1.5, color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(8)));
    return BlocSelector<PropertyTypeCubit, PropertyTypeState, PropertyTypes>(
        selector: (state) {
      return state.propertyTypes;
    }, builder: (context, state) {
      // Card color initial state
      if (state == PropertyTypes.values[position]) {
        cardColor = const Color(0xFFEBFAEF);
        cardShape = const RoundedRectangleBorder(
            side: BorderSide(width: 1.5, color: Color(0xFF32A854)),
            borderRadius: BorderRadius.all(Radius.circular(8)));
      }
      return InkWell(
          onTap: () {
            context.read<PropertyTypeCubit>().selectPropertyTypeEvent(position);
          },
          child: Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.only(top: 20),
              elevation: 6,
              color: cardColor,
              shape: cardShape,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      PropertyTypes.values[position].getIconPath(),
                      // color:const Color(0xff2C6ECB),
                    ),
                    Container(
                      height: 16,
                    ),
                    Text(PropertyTypes.values[position].name.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700))
                  ],
                ),
              )));
    });
  }
}
