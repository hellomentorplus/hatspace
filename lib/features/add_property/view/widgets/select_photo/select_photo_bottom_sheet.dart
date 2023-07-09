import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

enum PhotoTabs {
  allPhotos,
  // TODO add tab Album
  ;

  String get labelDisplay {
    switch (this) {
      case PhotoTabs.allPhotos:
        return HatSpaceStrings.current.allPhotos;
      // TODO add other tab
    }
  }

  Widget get tabView {
    switch (this) {
      case PhotoTabs.allPhotos:
        return const AllPhotosView();
      // TODO add other tab
    }
  }
}

class SelectPhotoBottomSheet extends StatefulWidget {
  const SelectPhotoBottomSheet({Key? key}) : super(key: key);

  @override
  State<SelectPhotoBottomSheet> createState() => _SelectPhotoBottomSheetState();
}

class _SelectPhotoBottomSheetState extends State<SelectPhotoBottomSheet>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 1, vsync: this);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(HsDimens.radius10),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: TabBar(
                    labelColor: HSColor.black,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing8,
                        vertical: HsDimens.spacing6),
                    indicatorColor: Colors.transparent,
                    controller: tabController,
                    tabs: PhotoTabs.values
                        .map((e) => Text(e.labelDisplay))
                        .toList()),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                child: InkWell(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(Assets.icons.close),
                ),
              )
            ],
          ),
          body: TabBarView(
              controller: tabController,
              children: PhotoTabs.values.map((e) => e.tabView).toList(),
            ),
        ),
      );
}

class AllPhotosView extends StatelessWidget {
  const AllPhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 1, crossAxisSpacing: 1),
        children: List.filled(
            15,
            Image.network(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D')),
      );
}

extension SelectPhotoBottomSheetExtension on BuildContext {
  Future<List<String>?> showSelectPhotoBottomSheet() {
    return showModalBottomSheet<List<String>>(
      context: this,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HsDimens.radius10)),
      builder: (context) => const FractionallySizedBox(
          heightFactor: 0.95, child: SelectPhotoBottomSheet()),
    );
  }
}
