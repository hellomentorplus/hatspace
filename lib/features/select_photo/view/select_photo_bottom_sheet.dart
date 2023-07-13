import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/select_photo/view/widgets/item_square_view.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/dimens/hs_dimens.dart';

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

class SelectPhotoBottomSheet extends StatelessWidget {
  const SelectPhotoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<SelectPhotoCubit>(
        create: (context) => SelectPhotoCubit()..loadPhotos(),
        child: const _SelectPhotoBottomSheet(),
      );
}

class _SelectPhotoBottomSheet extends StatefulWidget {
  const _SelectPhotoBottomSheet({Key? key}) : super(key: key);

  @override
  State<_SelectPhotoBottomSheet> createState() =>
      _SelectPhotoBottomSheetState();
}

class _SelectPhotoBottomSheetState extends State<_SelectPhotoBottomSheet>
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
                    horizontal: HsDimens.spacing8, vertical: HsDimens.spacing6),
                indicatorColor: Colors.transparent,
                controller: tabController,
                tabs:
                    PhotoTabs.values.map((e) => Text(e.labelDisplay)).toList()),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                child: InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(HsDimens.size24),
                  child: SvgPicture.asset(
                    Assets.icons.close,
                    width: HsDimens.size24,
                    height: HsDimens.size24,
                  ),
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
  Widget build(BuildContext context) =>
      BlocBuilder<SelectPhotoCubit, SelectPhotoState>(
        builder: (context, state) => state is PhotosLoaded
            ? GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 1),
                children: List.generate(
                  state.photos.length,
                  (index) => ImageSquareView(index: index),
                ))
            : const SizedBox(),
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
