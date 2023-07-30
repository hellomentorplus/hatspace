import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

typedef GetItemString<T> = String Function(T item);

class HsModalView<T> extends StatelessWidget {
  final String title;
  final GetItemString<T> getItemString;
  final List<T> itemList;
  final ValueChanged onSave;
  late final ValueNotifier<T>
      modalNotifier; // only used for render check icon on modal
  HsModalView(
      {required T selection,
      required this.itemList,
      required this.onSave,
      required this.getItemString,
      required this.title,
      super.key})
      : modalNotifier = ValueNotifier(selection);

  Widget renderSelectedItemIcon(
    T selectedValue,
    int index,
  ) {
    if (selectedValue == itemList[index]) {
      return SvgPicture.asset(Assets.icons.check);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.85,
        child: Padding(
            padding: const EdgeInsets.only(bottom: HsDimens.spacing40),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        bottom: HsDimens.spacing8, top: HsDimens.spacing24),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: HSColor.neutral2))),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            right: HsDimens.spacing24,
                            child: IconButton(
                              icon: SvgPicture.asset(Assets.icons.closeIcon),
                              onPressed: () => context.pop(),
                            )),
                        Center(
                            child: Text((title),
                                style: textTheme.displayLarge?.copyWith(
                                    fontSize: FontStyleGuide.fontSize16)))
                      ],
                    )),
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
                        return InkWell(
                            onTap: () {
                              modalNotifier.value = itemList[index];
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: HsDimens.spacing16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            getItemString(itemList[index]),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis)),
                                    const SizedBox(width: HsDimens.spacing12),
                                    ValueListenableBuilder(
                                        valueListenable: modalNotifier,
                                        builder: (_, value, context) {
                                          return renderSelectedItemIcon(
                                              value, index);
                                        })
                                  ],
                                )));
                      }),
                )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing24),
                    child: PrimaryButton(
                      label: HatSpaceStrings.current.save,
                      onPressed: () {
                        onSave(modalNotifier.value);
                      },
                    ))
              ],
            )));
  }
}
