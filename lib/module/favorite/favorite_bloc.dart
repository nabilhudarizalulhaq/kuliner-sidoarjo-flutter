import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kulineran/data/model/favorite_model.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  UserRepository? userRepository;
  String authToken = '';

  FavoriteBloc(
      this.userRepository,
  ) : super(FavoriteLoading()) {
    on<CheckLoginEvent>((event, emit) async {
      bool isLogin = false;
      await userRepository?.isLogin.then((value) {
        isLogin = value;
      });

      if(isLogin) {
        await userRepository?.getAuthToken.then((value) {
          authToken = value;
          emit(FavoriteIsLogin(authToken));
        });
      } else {
        emit(FavoriteIsNotLogin());
      }
    });

    on<GetFavoriteEvent>((event, emit) async {
      emit(FavoriteLoading());

      final response = await userRepository?.getFavorite(event.token);
      print('response ${response.toString()}');
      final result = response != null
          ? FavoriteLoaded(response)
          : FavoriteNotLoaded('no_data');
      emit( result );
    });

    on<DeleteFavoriteEvent>((event, emit) async {
      await userRepository?.deleteFavorite(authToken, event.placeId);
    });

  }
}
