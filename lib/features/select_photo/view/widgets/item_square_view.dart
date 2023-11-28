import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/select_photo/view_model/image_thumbnail_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';

class ImageSquareView extends StatelessWidget {
  final int index;

  const ImageSquareView({required this.index, super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SelectPhotoCubit, SelectPhotoState>(
        builder: (context, state) {
          if (state is PhotosLoaded) {
            return BlocProvider<ImageThumbnailCubit>(
              create: (context) =>
                  ImageThumbnailCubit()..createThumbnail(state.photos[index]),
              child: const ImageSquareBody(),
            );
          }

          return const SizedBox();
        },
      );
}

class ImageSquareBody extends StatelessWidget {
  const ImageSquareBody({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ImageThumbnailCubit, ImageThumbnailState>(
          builder: (context, state) {
        if (state is ThumbnailLoaded) {
          return GestureDetector(
            onTap: () {
              context
                  .read<PhotoSelectionCubit>()
                  .updateSelection(state.originalPath);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(state.thumbnail),
                        fit: state.width > state.height
                            ? BoxFit.fitHeight
                            : BoxFit.fitWidth,
                      )),
                ),
                BlocSelector<PhotoSelectionCubit, PhotoSelectionState, int?>(
                  selector: (selectionState) {
                    if (selectionState is PhotoSelectionUpdated) {
                      final int? index =
                          selectionState.getItemSelection(state.originalPath);
                      return index;
                    }

                    return null;
                  },
                  builder: (context, state) {
                    return state != null
                        ? Container(
                            alignment: Alignment.center,
                            color: HSColor.black.withOpacity(0.3),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary),
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(
                                  minWidth: HsDimens.size24,
                                  minHeight: HsDimens.size24),
                              child: Text(
                                state.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: HSColor.neutral1,
                                        fontSize: HsDimens.size12),
                                textAlign: TextAlign.center,
                              ),
                            ))
                        : const SizedBox();
                  },
                )
              ],
            ),
          );
        }

        // TODO handle error

        return const SizedBox();
      });
}
