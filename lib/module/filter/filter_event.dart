part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class GetSubDistrictEvent extends FilterEvent {

  @override
  List<Object?> get props => [];
}

class AddFilterEvent extends FilterEvent {

  String id;
  String name;
  bool refresh;
  AddFilterEvent(this.id, this.name, this.refresh);

  @override
  List<Object?> get props => [id, name, refresh];
}

class GetFilterEvent extends FilterEvent {

  @override
  List<Object?> get props => [];
}
