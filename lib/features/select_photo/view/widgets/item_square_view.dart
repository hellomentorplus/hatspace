import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatspace/features/select_photo/view_model/image_thumbnail_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';

class ImageSquareView extends StatelessWidget {
  final int index;

  const ImageSquareView({required this.index, Key? key}) : super(key: key);

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
  const ImageSquareBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ImageThumbnailCubit, ImageThumbnailState>(
          builder: (context, state) {
        if (state is ThumbnailLoaded) {
          return Image.file(
            state.thumbnail,
            fit:
                state.width > state.height ? BoxFit.fitHeight : BoxFit.fitWidth,
            cacheWidth: state.width > state.height ? 300 : null,
            cacheHeight: state.width > state.height ? null : 300,
          );
        }

        // TODO handle error

        return const SizedBox();
      });
}
