import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/info_form/property_infor_form.dart';

class AddPropertyView extends StatelessWidget {
  const AddPropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add property'),
        ),
        body: PropertyInforForm()
      );
}
