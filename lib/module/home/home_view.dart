import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/detail/detail_view.dart';
import 'package:kulineran/module/filter/filter_bloc.dart';
import 'package:kulineran/module/home/home_bloc.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';
import 'package:kulineran/data/model/place_model.dart' as placeModel;
import 'package:kulineran/utils/helper_utils.dart' as helper;

class HomeView extends StatefulWidget {

  // final HomeBloc? homeBloc;
  final String? keyword;

  const HomeView({
    // this.homeBloc,
    this.keyword,
    Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeBloc? homeBloc;
  FilterBloc? filterBloc;
  List<int> selectedIds = [];

  @override
  void initState() {
    homeBloc = HomeBloc ( RepositoryProvider.of<UserRepository>(context) );
    homeBloc?.add(GetPlaceEvent(''));
    filterBloc = FilterBloc ( RepositoryProvider.of<UserRepository>(context) );
    filterBloc?.add(GetFilterEvent());
    super.initState();
  }

  Widget _buildFavoriteIcon(int placeId){
    return Container(
      child: selectedIds.toString().contains(placeId.toString()) ? IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.pink,
        ),
        onPressed: () {
          print('icon: placeId ${placeId.toString()}');
          // setState(() {
          //   selectedIds.removeWhere((element) {
          //     return element == placeId;
          //   });
          // });
        },
      ) : IconButton(
        icon: Icon(
          Icons.favorite_border,
          color: Colors.pink,
        ),
        onPressed: () {
          print('icon: placeId ${placeId.toString()}');
          homeBloc?.add(AddFavoriteEvent(placeId));
          setState(() {
            selectedIds.add(placeId);
          });
        },
      ),
    );
  }

  Widget _buildPlaceList(
      placeModel.PlaceModel homePlace,
      List<placeModel.Data> listPlace
  ){
    print('_buildListPlace: selectedIds ${selectedIds.toString()}');
    // print('_buildListPlace: keyword ${widget.keyword}');
    return ListView.builder(
        itemCount: listPlace.length,
        itemBuilder: (context, position) {
          return Container(
            child: InkWell(
              child: Column (
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/img_thumbnail.png",
                              image: listPlace[position].image,
                              // image: 'https://oomphcdn01.sgp1.digitaloceanspaces.com/files/uploads/shareit_contents/2021/06/07/67995/10_20210607015145_ket.jpg',
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/img_thumbnail.png",),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: Expanded(
                                  child: Column(
                                    children: [
                                      Padding (
                                        padding: EdgeInsets.only(top: 8),
                                        child: Align (
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            listPlace[position].name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding (
                                        padding: EdgeInsets.only(top: 4),
                                        child: Align (
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            listPlace[position].subDistrict.name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            _buildFavoriteIcon(listPlace[position].id),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container( color: Colors.black12, height: 0.5 ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                    Constant.routeDetail,
                    arguments: DetailView(
                        placeId: listPlace[position].id
                    )
                );
              },
            ),
          );
        }
    );
  }

  Widget _buildFilterKecamatan(){
    return BlocProvider(
      create: (context) => filterBloc!,
      child: BlocConsumer<FilterBloc, FilterState>(
        listener: (context, state) {
          print('FilterState: state ${state.toString()}');
        },
        builder: (context, state) {
          if(state is FilterLoaded) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton.icon(
                icon: Text(state.name, style: TextStyle(color: Colors.black54),),
                label: Icon(Icons.close, size: 16, color: Colors.black54,),
                onPressed: () {
                  print('filter: click ${state.id}');
                  filterBloc?.add(AddFilterEvent('', '', true));
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  onSearch() async {
    print('onSearch: keyword ${widget.keyword}');
    if(widget.keyword != null ) {
      homeBloc?.add(SearchPlaceEvent(widget.keyword!));
    }
  }

  @override
  Widget build(BuildContext context) {
    onSearch();
    return FocusDetector(
      onFocusGained: () => filterBloc?.add(GetFilterEvent()),
        child: BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState> (
            listener: (context, state) {
              print('HomeBloc: state ${state.toString()}');
              if (state is HomeNoInternet) {
                helper.toastMessage(context, 'No Internet Connection');
              }
            },
            builder: (context, state) {
              if(state is HomeLoaded) {
                return Container (
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildFilterKecamatan(),
                        Expanded(
                            child: _buildPlaceList (
                                state.placeModel,
                                state.placeModel.data
                            )
                        )
                      ],
                    )
                );
              } else if(state is HomeNoInternet) {
                return Container(
                  color: Colors.white,
                );
              } else {
                return ProgressLoadingView();
              }
            },
          ),
        )
    );
  }
}

