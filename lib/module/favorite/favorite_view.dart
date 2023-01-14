import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/detail/detail_view.dart';
import 'package:kulineran/module/favorite/favorite_bloc.dart';
import 'package:kulineran/utils/helper_utils.dart' as helper;
import 'package:kulineran/utils/widget/login_required_view.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';
import 'package:kulineran/data/model/favorite_model.dart' as favoriteModel;

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {

  FavoriteBloc? favoriteBloc;
  List<int> selectedIds = [];

  @override
  void initState() {
    favoriteBloc = FavoriteBloc (
      RepositoryProvider.of<UserRepository>(context), );
    favoriteBloc?.add(CheckLoginEvent());
    super.initState();
  }

  Widget _buildListFavorite(List<favoriteModel.Data> listFavorite){
    return ListView.builder(
        itemCount: listFavorite.length,
        itemBuilder: (context, position) {
          return Container(
            child: InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(
                    Constant.routeDetail,
                    arguments: DetailView(placeId: listFavorite[position].id)
                );
              },
              child: Column (
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 150.0,
                          height: 100.0,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/ragam_kuliner.jpg",
                              image: listFavorite[position].image,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/ragam_kuliner.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              children: [
                                Padding (
                                  padding: EdgeInsets.only(left: 8),
                                  child: Align (
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      listFavorite[position].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87
                                      ),
                                    ),
                                  ),
                                ),
                                Padding (
                                  padding: EdgeInsets.only(left: 8,top: 4),
                                  child: Align (
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      listFavorite[position].subDistrict.name,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                        _buildIconFavorite(listFavorite[position].id)
                      ],
                    ),
                  ),
                  Container( color: Colors.black12, height: 0.5 ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildIconFavorite(int placeId){
    return Container(
      child: selectedIds.toString().contains(placeId.toString()) ? IconButton(
        icon: Icon(
          Icons.favorite_border,
          color: Colors.pink,
        ),
        onPressed: () {
          print('icon: placeId ${placeId.toString()}');
        },
      ) : IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.pink,
        ),
        onPressed: () {
          print('icon: placeId ${placeId.toString()}');
          favoriteBloc?.add(DeleteFavoriteEvent(placeId));
          setState(() {
            selectedIds.add(placeId);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteBloc!,
      child: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          print('FavoriteView: state $state');
          if(state is FavoriteIsLogin) {
            favoriteBloc?.add(GetFavoriteEvent(state.token));
          } else if(state is FavoriteDeleted) {
            helper.toastMessage(context, state.message);
          }
        },
        builder: (context, state) {
          if(state is FavoriteLoading) {
            return ProgressLoadingView();
          } else if(state is FavoriteIsNotLogin) {
            return LoginRequiredView( callback: () {
              favoriteBloc?.add(CheckLoginEvent());
            });
          } else if(state is FavoriteLoaded) {
            return Container (
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      child: _buildListFavorite(state.favoriteModel.data)
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

}

