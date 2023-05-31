import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_button_settings.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';


class HatSpaceInputText  extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isRequired;
  final bool optionalLabel;

  const HatSpaceInputText({
    super.key, 
    required this.label,
    bool? isRequired,
    required this.placeholder,
    bool? optionalLabel
    }): isRequired = isRequired?? false,
        optionalLabel = optionalLabel ?? false;
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            text: label,
            children:[
              TextSpan(
                text: isRequired? " *": optionalLabel ? " (Optional)" : "",
                style: textTheme.bodyMedium?.copyWith(color: HSColor.requiredField)
              )
            ] 
            ) 
        ),
        TextFormField(
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            decoration: inputTextTheme.copyWith(hintText: placeholder))
      ],
    );
  }
}

class HatSpaceDropDownButton extends StatelessWidget{
  final String label;
  final bool isRequired;
  final String placeholder;
  final VoidCallback onPressed;
  const HatSpaceDropDownButton({
    super.key,
    required this.label,
    bool? isRequired,
    required this.onPressed,
    required this.placeholder
    }):isRequired = isRequired ?? false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
         RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            text: label,
            children:[
              TextSpan(
                text: isRequired? " *": "",
                style: textTheme.bodyMedium?.copyWith(color: HSColor.requiredField)
              )
            ] 
            ) 
        ),
    SecondaryButton(
      // TODO: implement placeholder with enum of preriod
      label: placeholder, 
      iconUrl: Assets.images.chervonDown, 
      iconPosition: IconPosition.right,
      contentAlignment: MainAxisAlignment.spaceBetween,
      style: secondaryButtonTheme.style?.copyWith(
        textStyle: MaterialStatePropertyAll<TextStyle?>(
            Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.fromLTRB(16, 13, 12, 13))
      ),
      onPressed: (){
        // TODO: implement show rent period
      },
      ),
      ],
    );

  }
  
}

// input THEME
InputDecoration inputTextTheme = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: HSColor.black,
        )),
    hintText: "Please enter your placeholder",
    hintStyle:
        textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5));

class PropertyInforForm extends StatelessWidget {
  PropertyInforForm({super.key});

  List<Widget> itemList = [
    const Text("Information",
        style: TextStyle(
            fontSize: 24,
            color: HSColor.onSurface,
            fontWeight: FontWeight.w700)),
    const PropertyName(),
    const PropertyPrice(),
    const PropertyRentPeriod(),
    const PropertyDescription(placeholder: "Enter description"),
    const Text("Your address",
    style: TextStyle(
            fontSize: 18,
            color: HSColor.onSurface,
            fontWeight: FontWeight.w700)),
            const PropertyState()
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 33, right: 16),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 16,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return itemList[index];
            },
          ),
        ));
  }
}

class PropertyName extends StatelessWidget {
  const PropertyName({super.key});

  @override
  Widget build(BuildContext context) {
    return const HatSpaceInputText(label: "Property name", placeholder: "Enter property name", isRequired: true,);
  }
}

class PropertyPrice extends StatelessWidget {
  const PropertyPrice({super.key});
  @override
  Widget build(BuildContext context) {
    return 
      Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price"),
 Card(
        color: Colors.white,
        elevation: 4.0,
        shadowColor: HSColor.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: HSColor.black),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: inputTextTheme.copyWith(border:OutlineInputBorder(borderSide: BorderSide.none)),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.0),
              ),
            ),
            Padding(padding: const EdgeInsets.only(
              right: 7,
              left: 16
            ),
            child: 
      Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(4),
                color: HSColor.neutral2
              ),
              
              child: const Text("USD (\$)",
                style: TextStyle(
 
                ),
              )
            )
            
            )
      
          ],
        ))
        ],
      );
   
  }
}

class PropertyRentPeriod extends StatelessWidget{
  const PropertyRentPeriod({super.key});
  @override
  Widget build(context){
    return HatSpaceDropDownButton(label: "Minimum rent period",placeholder: "6 months", isRequired: true, onPressed: (){

    });
  }
}

class PropertyDescription extends StatelessWidget{
  final String placeholder;
  const PropertyDescription({super.key,
  required this.placeholder
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
                Text("Description"),
                // TODO: Change state
                Text("120/4000")
          ],
        ),
        TextFormField(
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: inputTextTheme.copyWith(hintText: placeholder),
        )
      ],
    );
  }
}

class PropertyState extends StatelessWidget{
  const PropertyState({super.key});
  
  @override
  Widget build(Object context) {
    // TODO: implement build
    return HatSpaceDropDownButton(label: "State",placeholder: "Select", isRequired: true,onPressed: (){

    });
  }
  
}
