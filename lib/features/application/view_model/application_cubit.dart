import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationInitial());

  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();

  void downloadApplicationForm() {
    _storageService.files.downloadFile(
      (value) {
        if (!isClosed) {
          emit(DownloadFileCompleted(value));
        }
      },
      onStart: () {
        if (!isClosed) {
          emit(DownloadFileStart());
        }
      },
      onDownloading: (bytes) {
        if (!isClosed) {
          emit(DownloadFileInProgress(bytes));
        }
      },
      onPaused: () {
        if (!isClosed) {
          emit(DownloadFilePaused());
        }
      },
      onError: () {
        if (!isClosed) {
          emit(DownloadFileError());
        }
      },
      onCancel: () {
        if (!isClosed) {
          emit(DownloadFileCancel());
        }
      },
    );
  }
}
