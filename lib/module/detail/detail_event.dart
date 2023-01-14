part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class GetDetailEvent extends DetailEvent {

  final int id;
  GetDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class NoInternetEvent extends DetailEvent {
  @override
  List<Object?> get props => [];
}
