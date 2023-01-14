import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:kulineran/data/constant.dart' ;
import 'package:kulineran/data/model/place_model.dart' as placeModel;
import 'package:kulineran/data/model/place_detail_model.dart' as detailModel;
import 'package:kulineran/data/model/login_model.dart' as loginModel;
import 'package:kulineran/data/model/error_model.dart' as errorModel;
import 'package:kulineran/data/model/register_model.dart' as registerModel;
import 'package:kulineran/data/model/profile_model.dart' as profileModel;
import 'package:kulineran/data/model/favorite_model.dart' as favoriteModel;
import 'package:kulineran/data/model/sub_district_model.dart' as subDistrictModel;
import 'package:kulineran/data/model/place_menu_model.dart' as placeMenuModel;
import 'package:kulineran/data/remote/logging_interceptor.dart';

class ApiService {

  Client _client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);

  Map<String, String> setHeader(bearer) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearer',
    };
  }

  Future<placeModel.PlaceModel> getPlace(
      String keyword
  ) async {
    final url = Uri.https(
        Constant.baseUrl,
        Constant.apiPLace,
      {
        'keyword' : keyword
      }
    );
    final response = await _client.get(url);
    final json = jsonDecode( response.body );
    return placeModel.PlaceModel.fromJson(json);
  }

  Future<detailModel.PlaceDetailModel> getPlaceDetail( int placeId ) async {
    final path = '${Constant.apiPLace}/$placeId';
    final url = Uri.https(Constant.baseUrl, path);
    final response = await _client.get(url);
    final json = jsonDecode( response.body );
    return detailModel.PlaceDetailModel.fromJson(json);
  }

  Future<placeMenuModel.PlaceMenuModel> getPlaceMenu( int placeId ) async {
    final path = '${Constant.apiPLace}/$placeId/menu';
    final url = Uri.https(Constant.baseUrl, path);
    final response = await _client.get(url);
    final json = jsonDecode( response.body );
    return placeMenuModel.PlaceMenuModel.fromJson(json);
  }

  Future<placeModel.PlaceModel> getPlaceRelated( int subDistrictId ) async {
    final path = '${Constant.apiSubDistrict}/$subDistrictId/place';
    final url = Uri.https(Constant.baseUrl, path);
    final response = await _client.get(url);
    final json = jsonDecode( response.body );
    return placeModel.PlaceModel.fromJson(json);
  }

  Future<dynamic> userLogin(
      String email,
      String password,
    ) async {
    final url = Uri.https(Constant.baseUrl, Constant.apiLogin);
    final response = await _client.post(
        url,
        body: {
          'email': email,
          'password': password,
        }
    );
    final json = jsonDecode( response.body );
    try {
      return loginModel.LoginModel.fromJson(json);
    } catch(e) {
      return errorModel.ErrorModel.fromJson(json);
    }
  }

  Future<dynamic> userRegister(
      String name,
      String email,
      String password,
      String passwordConfirmation,
      ) async {
    final url = Uri.https(Constant.baseUrl, Constant.apiRegister);
    final response = await _client.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }
    );
    final json = jsonDecode( response.body );

    try {
      return registerModel.RegisterModel.fromJson(json);
    } catch(e) {
      return errorModel.ErrorModel.fromJson(json);
    }
  }

  Future<profileModel.ProfileModel> getProfile( String token ) async {
    final url = Uri.https(Constant.baseUrl, Constant.apiUser);
    final response = await _client.get(
        url, headers: setHeader( token )
    );
    final json = jsonDecode( response.body );
    return profileModel.ProfileModel.fromJson(json);
  }

  Future<favoriteModel.FavoriteModel> getFavorite( String token ) async {
    final url = Uri.https(Constant.baseUrl, Constant.apiFavorite);
    final response = await _client.get(
        url, headers: setHeader( token )
    );

    final json = jsonDecode( response.body );
    return favoriteModel.FavoriteModel.fromJson(json);
  }

  Future<favoriteModel.FavoriteAddModel> addFavorite(
      String token,
      int placeId,
  ) async {
    final path = '/api/user/place/$placeId/favourite';
    final url = Uri.https(Constant.baseUrl, path);
    final response = await _client.post(
        url,
        headers: setHeader(token)
    );
    final json = jsonDecode( response.body );
    return favoriteModel.FavoriteAddModel.fromJson(json);
  }

  Future<favoriteModel.FavoriteDeleteModel> deleteFavorite(
      String token,
      int placeId,
  ) async {
    final path = '/api/user/place/$placeId/favourite';
    final url = Uri.https(Constant.baseUrl, path);
    final response = await _client.delete(
        url,
        headers: setHeader(token)
    );
    final json = jsonDecode( response.body );
    return favoriteModel.FavoriteDeleteModel.fromJson(json);
  }

  Future<subDistrictModel.SubDistrictModel> getSubDistrict() async {
    final url = Uri.https(Constant.baseUrl, Constant.apiSubDistrict);
    final response = await _client.get( url );
    final json = jsonDecode( response.body );
    return subDistrictModel.SubDistrictModel.fromJson(json);
  }

}