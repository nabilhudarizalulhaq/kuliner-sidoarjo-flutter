
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/model/favorite_model.dart';
import 'package:kulineran/data/model/place_detail_model.dart';
import 'package:kulineran/data/model/place_menu_model.dart';
import 'package:kulineran/data/model/place_model.dart';
import 'package:kulineran/data/model/sub_district_model.dart';
import 'package:kulineran/data/preferences/pref_service.dart';
import 'package:kulineran/data/remote/api_service.dart';

class UserRepository{

  final apiService = ApiService();
  final prefService = PrefService();

  Future<PlaceModel> getPlace(String keyword) => apiService.getPlace(keyword);

  Future<PlaceDetailModel> getPlaceDetail(int placeId) =>
      apiService.getPlaceDetail(placeId);

  Future<PlaceMenuModel> getPlaceMenu(int placeId) =>
      apiService.getPlaceMenu(placeId);

  Future<PlaceModel> getPlaceRelated(int subDistrictId) =>
      apiService.getPlaceRelated(subDistrictId);

  Future<dynamic> userLogin(String email, String password) =>
      apiService.userLogin(email, password);

  Future<bool> get isLogin => prefService.getBool( Constant.prefIsLogin );
  Future setIsLogin(String token) async {
    await prefService.setBool(Constant.prefIsLogin, true);
    await setAuthToken(token);
  }

  Future<String> get getAuthToken =>
      prefService.getString( Constant.prefAuthToken );
  Future setAuthToken(String value) =>
      prefService.setString(Constant.prefAuthToken, value);

  Future userLogout() => prefService.setBool( Constant.prefIsLogin , false);

  Future<dynamic> userRegister(
      String name,
      String email,
      String password,
      String passwordConfirmation,
  ) => apiService.userRegister(name, email, password, passwordConfirmation);

  Future getProfile(String token) => apiService.getProfile(token);

  Future<FavoriteModel> getFavorite( String token ) =>
      apiService.getFavorite(token);

  Future<FavoriteAddModel> addFavorite(
      String token,
      int placeId
  ) => apiService.addFavorite(token, placeId);

  Future<FavoriteDeleteModel> deleteFavorite(
      String token,
      int placeId
  ) => apiService.deleteFavorite(token, placeId);

  Future<SubDistrictModel> getSubDistrict() => apiService.getSubDistrict();

  Future setFilter(String id, String name) async {
    await prefService.setString( Constant.prefFilterId , id);
    await prefService.setString( Constant.prefFilterName , name);
  }

}