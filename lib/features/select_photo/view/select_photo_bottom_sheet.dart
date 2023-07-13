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

class AllPhotosView extends StatefulWidget {
  const AllPhotosView({Key? key}) : super(key: key);

  @override
  _AllPhotosViewState createState() => _AllPhotosViewState();
}

class _AllPhotosViewState extends State<AllPhotosView> {
  List<bool> isSelectedList = List.filled(15, false);
  List<int> selectedIndices = [];
  int selectedCount = 0;

  // @override
  // Widget build(BuildContext context) =>
  //     BlocBuilder<SelectPhotoCubit, SelectPhotoState>(
  //       builder: (context, state) => state is PhotosLoaded
  //           ? GridView(
  //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 4,
  //               childAspectRatio: 1,
  //               crossAxisSpacing: 1),
  //           children: List.generate(
  //             state.photos.length,
  //                 (index) => ImageSquareView(index: index),
  //           ))
  //           : const SizedBox(),
  //     );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelectedList[index]) {
                isSelectedList[index] = false;
                selectedIndices.remove(index);
                selectedCount--;
              } else if (selectedCount < 10) {
                isSelectedList[index] = true;
                selectedIndices.add(index);
                selectedCount++;
              }
            });
          },
          child: Stack(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                fit: BoxFit.cover,
              ),
              if (isSelectedList[index]) ...[
                Container(color: Colors.black.withOpacity(0.3)),
                Center(
                  child: Container(
                    // color: Colors.black.withOpacity(0.3),
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    width: HsDimens.size24,
                    height: HsDimens.size24,
                    padding:
                    const EdgeInsets.symmetric(vertical: HsDimens.spacing4),
                    child: Center(
                      child: Text(
                        (selectedIndices.indexOf(index) + 1).toString(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: HSColor.neutral1, fontSize: HsDimens.size12),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
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
