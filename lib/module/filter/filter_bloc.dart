import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/model/sub_district_model.dart';
import 'package:kulineran/data/repository/user_repository.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {

  UserRepository? userRepository;

  FilterBloc(
      this.userRepository,
  ) : super(FilterInitial()) {

    on<GetSubDistrictEvent>((event, emit) async {
      emit(SubDistrictLoading());
      final response = await userRepository?.getSubDistrict();
      final result = response != null
          ? SubDistrictLoaded(response)
          : SubDistrictNotLoaded('no_data');
      emit( result );
    });

    on<AddFilterEvent>((event, emit) async {
      await userRepository?.setFilter(event.id, event.name).then((value) {
        emit(FilterAdded());
      });
      if (event.refresh) {
        add(GetFilterEvent());
      }
    });

    on<GetFilterEvent>((event, emit) async {

      String filterId ='';
      String filterName ='';

      await userRepository?.prefService.getString(
          Constant.prefFilterId
      ).then((value) {
        filterId = value;
      });
      await userRepository?.prefService.getString(
          Constant.prefFilterName
      ).then((value) {
        filterName = value;
      });

      if(filterId.isEmpty) {
        emit(FilterNotLoaded());
      } else {
        emit(FilterLoaded(filterId, filterName));
      }

    });

  }
}
