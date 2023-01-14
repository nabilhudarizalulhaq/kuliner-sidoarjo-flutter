import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:kulineran/data/model/place_detail_model.dart';
import 'package:kulineran/data/model/place_menu_model.dart';
import 'package:kulineran/data/model/place_model.dart';
import 'package:kulineran/data/remote/connectivity_service.dart';
import 'package:kulineran/data/repository/user_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {

  UserRepository? userRepository;
  var connectivity = ConnectivityService();

  DetailBloc(
      this.userRepository,
  ) : super(DetailLoading()) {

    connectivity.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('no internet');
        add(NoInternetEvent());
      }
    });

    on<NoInternetEvent>((event, emit) async {
      print('DetailBloc: NoInternetEvent');
      emit(DetailNoInternet());
    });
    
    on<GetDetailEvent>((event, emit) async {
      emit(DetailLoading());
      final detail = await userRepository?.getPlaceDetail(event.id);
      final menu = await userRepository?.getPlaceMenu(event.id);
      final place = await userRepository?.getPlaceRelated(
        detail!.data.subDistrict.id
      );
      final result = detail != null
          ? DetailLoaded(detail, menu, place) : DetailNotLoaded('no_data');
      emit( result );
    });
    
  }
}
