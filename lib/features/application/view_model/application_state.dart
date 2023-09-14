part of 'application_cubit.dart';

abstract class ApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApplicationInitial extends ApplicationState {}

class DownloadFileCompleted extends ApplicationState {
  final String path;

  DownloadFileCompleted(this.path);

  @override
  List<Object?> get props => [path];
}

class DownloadFileInProgress extends ApplicationState {
  final int bytes;

  DownloadFileInProgress(this.bytes);

  @override
  List<Object?> get props => [bytes];
}

class DownloadFilePaused extends ApplicationState {}

class DownloadFileError extends ApplicationState {}

class DownloadFileCancel extends ApplicationState {}

class DownloadFileStart extends ApplicationState {}