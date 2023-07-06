part of 'get_properties_cubit.dart';

abstract class GetPropertiesState extends Equatable {
  const GetPropertiesState();

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
