part of 'get_properties_cubit.dart';

abstract class GetPropertiesState extends Equatable {
  const GetPropertiesState();

  // bool get isInitialState => this is GetPropertiesInitialState;
  // bool get isGettingPropertiesState => this is GettingPropertiesState;
  // bool get isGetPropertiesSucceed => this is GetPropertiesSucceedState;
  // bool get isGetPropertiesFailed => this is GetPropertiesFailedState;

  // List<PropertyItemData> get properties =>
  //     (this as GetPropertiesSucceedState).propertyList;

  @override
  List<Object?> get props => [];
}

class GetPropertiesInitialState extends GetPropertiesState {
  const GetPropertiesInitialState();
}

class GettingPropertiesState extends GetPropertiesState {
  const GettingPropertiesState();
}

class GetPropertiesSucceedState extends GetPropertiesState {
  final List<PropertyItemData> propertyList;

  const GetPropertiesSucceedState(this.propertyList);

  @override
  List<Object?> get props => propertyList;
}

class GetPropertiesFailedState extends GetPropertiesState {
  const GetPropertiesFailedState();
}
