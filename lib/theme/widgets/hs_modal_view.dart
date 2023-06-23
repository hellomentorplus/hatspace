import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HsModalView<T> extends StatelessWidget {
  final String title;
  final ValueNotifier currentValue;
  final List<dynamic> itemList;
  final ValueChanged onSave;
  final double? height;
  const HsModalView(
      {required this.currentValue,
      required this.itemList,
      required this.height,
      required this.title,
      required this.onSave,
      super.key});

  Widget renderSelectedItemIcon(dynamic selectedValue, int index) {
    if (selectedValue == itemList[index]) {
      return SvgPicture.asset(Assets.images.check);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        key: key,
        height: height,
        child: Padding(
            padding: const EdgeInsets.only(bottom: HsDimens.spacing40),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      bottom: HsDimens.spacing8, top: HsDimens.spacing24),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: HSColor.neutral2))),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      Expanded(
                          child: Center(
                        child: Text(
                          title,
                          style: textTheme.displayLarge
                              ?.copyWith(fontSize: FontStyleGuide.fontSize16),
                        ),
                      )),
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: SvgPicture.asset(Assets.images.closeIcon),
                                onPressed: () {
                                  context.pop();
                                },
                              )))
                    ],
                  ),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HsDimens.spacing24,
                  ),
                  child: ListView.separated(
                      separatorBuilder: (_, index) {
                        return const Divider(
                          thickness: 1.0,
                          color: HSColor.neutral3,
                        );
                      },
                      itemCount: itemList.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                            onTap: () {
                              currentValue.value = itemList[index];
                            },
                            child: ValueListenableBuilder(
                                valueListenable: currentValue,
                                builder: (_, value, child) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: HsDimens.spacing16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemList[index].displayName,
                                          ),
                                          renderSelectedItemIcon(value, index)
                                        ],
                                      ));
                                }));
                      }),
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing24),
                    child: TertiaryButton(
                      style: const ButtonStyle(
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(HSColor.background),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(HSColor.green06),
                      ),
                      label: HatSpaceStrings.of(context).save,
                      onPressed: () {
                        onSave(currentValue.value);
                      },
                    ))
              ],
            )));
  }
}
