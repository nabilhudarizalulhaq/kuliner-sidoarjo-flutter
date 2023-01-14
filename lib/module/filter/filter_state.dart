part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class SubDistrictLoading extends FilterState {
  @override
  List<Object> get props => [];
}

class SubDistrictLoaded extends FilterState {

  SubDistrictModel subDistrictModel;
  SubDistrictLoaded(this.subDistrictModel);

  @override
  List<Object> get props => [subDistrictModel];
}

class SubDistrictNotLoaded extends FilterState {

  String message;
  SubDistrictNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class FilterAdded extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterLoaded extends FilterState {

  String id;
  String name;
  FilterLoaded(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}

class FilterNotLoaded extends FilterState {

  @override
  List<Object> get props => [];
}
