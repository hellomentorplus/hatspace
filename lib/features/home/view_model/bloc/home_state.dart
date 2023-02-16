part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class ShowWidgetCatalogState extends HomeState {
  final bool isShowCatalog;
  const ShowWidgetCatalogState(this.isShowCatalog);
  @override
  List<Object> get props => [isShowCatalog];
}

class HomeInitial extends HomeState {}
