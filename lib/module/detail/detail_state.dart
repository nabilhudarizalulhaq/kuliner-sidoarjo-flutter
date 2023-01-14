part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class DetailInitial extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoaded extends DetailState {

  PlaceDetailModel placeDetailModel;
  PlaceMenuModel? placeMenuModel;
  PlaceModel? placeModel;

  DetailLoaded(this.placeDetailModel, this.placeMenuModel, this.placeModel);

  @override
  List<Object> get props => [placeDetailModel];
}

class DetailNotLoaded extends DetailState {

  final String message;

  DetailNotLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class DetailNoInternet extends DetailState {
  @override
  List<Object> get props => [];
}
