
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/model/place_model.dart';
import 'package:kulineran/data/remote/connectivity_service.dart';
import 'package:kulineran/data/repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  UserRepository? userRepository;
  var connectivity = ConnectivityService();

  HomeBloc(
      this.userRepository,
  ) : super(HomeLoading()) {

    connectivity.connectivityStream.stream.listen((event) {
      print('connectivityStream: event ${event.toString()}');
      if(event == ConnectivityResult.none) {
        print('HomeBloc: NoInternetEvent');
        add(NoInternetEvent());
      } else {
        add(GetPlaceEvent(''));
      }
    });

    on<NoInternetEvent>((event, emit) async {
      print('DetailBloc: NoInternetEvent');
      emit(HomeNoInternet());
    });

    on<GetPlaceEvent>((event, emit) async {
      emit(HomeLoading());
      dynamic place;
      try {
        place = await userRepository?.getPlace(event.keyword);
      } catch (e) {
        print('GetPlaceEvent: Error $e');
      }
      final result = place != null
          ? HomeLoaded(place) : HomeNotLoaded('no_data');
      print('HomeBloc: HomeNotLoaded');
      emit( result );
    });

    on<AddFavoriteEvent>((event, emit) async {
      bool isLogin = false;
      await userRepository?.isLogin.then((value) {
        isLogin = value;
      });

      if(isLogin) {
        String? token = await userRepository?.getAuthToken;
        var response = await userRepository?.addFavorite(token!, event.placeId);
        // emit(FavoriteAdded( response!.message ));
        return;
      }

      // emit(FavoriteAdded('login is required'));
    });

    on<SearchPlaceEvent>((event, emit) async {
      String keywordOld = '';
      await userRepository?.prefService
          .getString(Constant.prefSearchKeyword).then((value) {
            keywordOld = value;
          });

      if (event.keyword != keywordOld) {
        String keywordNew = event.keyword;
        await userRepository?.prefService
            .setString(Constant.prefSearchKeyword, keywordNew);
        add(GetPlaceEvent(keywordNew));
      }

    });

  }

}
