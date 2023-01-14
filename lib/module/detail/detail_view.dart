import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/detail/detail_bloc.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';
import 'package:latlong2/latlong.dart' as latLng ;
import 'package:maps_launcher/maps_launcher.dart';

import 'package:kulineran/data/model/place_detail_model.dart'
  as detailModel;
import 'package:kulineran/data/model/place_menu_model.dart'
  as menuModel;
import 'package:kulineran/data/model/place_model.dart'
  as placeModel;

class DetailView extends StatefulWidget {

  final int? placeId;

  const DetailView({
    Key? key,
    this.placeId
  }) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  DetailBloc? _detailBloc;

  List listMenu = [
    'Nasi Hittler',
    'Chicken Karaage',
    'Tempura Prawn',
    'Mummy Roll',
    'Geisha Roll',
    'Zombie Roll'
        'Spicy Chicken Wings',
    'Sushi Monster Roll',
    'Sushi Godzilla Roll',
    'Sushi Vampire Roll'
  ];


  @override
  void initState() {
    _detailBloc = DetailBloc(
      RepositoryProvider.of<UserRepository>(context),
    );
    _detailBloc?.add(GetDetailEvent( widget.placeId! ));
    print('detail: placeId ${widget.placeId}');
    super.initState();
  }

  Widget _buildPlace(String placeImage, String placeTitle){
    return Column(
      children: [
        Container(
          child: FadeInImage.assetNetwork(
            placeholder: "assets/ragam_kuliner.jpg",
            image: placeImage,
            imageErrorBuilder: (context, error, stackTrace) => Image.asset("assets/ragam_kuliner.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding (
                    padding: EdgeInsets.all(8.0),
                    child: Align (
                      alignment: Alignment.centerLeft,
                      child: Text( placeTitle, style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink
                      ), ),
                    ),
                  ),
                  Padding (
                    padding: EdgeInsets.only(left: 8.0),
                    child: Align (
                      alignment: Alignment.centerLeft,
                      child: Text( 'Beberapa orang menyukai tempat ini', style: TextStyle(fontSize: 14, color: Colors.grey ), ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                    // add favorite here
                  },
                ),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          color: Colors.black12,
          height: 0.5,
        ),
      ],
    );
  }

  Widget _buildMenu(menuModel.PlaceMenuModel? menu){
    List<menuModel.Data> listMenu = [];
    if(menu != null ) {
      listMenu = menu.data.isNotEmpty ? menu.data : [];
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container (
          margin: EdgeInsets.only(top: 8.0),
          padding: EdgeInsets.all(8.0),
          child: Align (
            alignment: Alignment.centerLeft,
            child: Text( 'Pilihan Menu',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),
        ),
        Container(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listMenu.length,
              itemBuilder: (context, position) {
                return Container(
                  child: Column (
                    children: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/ragam_kuliner.jpg",
                            image: listMenu[position].image,
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
                      Container (
                        width: 100,
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          listMenu[position].name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          color: Colors.black12,
          height: 0.5,
        ),
      ],
    );
  }

  Widget _buildLocation(
      String address,
      String latitude,
      String longitude,
  ) {
    return Column(
      children: [
        Container (
          margin: EdgeInsets.only(top: 16.0, left: 8.0),
          child: Align (
            alignment: Alignment.centerLeft,
            child: Text( 'Lokasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87 ),
            ),
          ),
        ),
        Container (
          margin: EdgeInsets.only(top: 8.0, left: 8.0),
          child: Align (
            alignment: Alignment.centerLeft,
            child: Text( address,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54 ),
            ),
          ),
        ),
        SizedBox(height: 16,),
        Container(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              // center: latLng.LatLng(-7.4452562, 112.7052241),
              center: latLng.LatLng(double.parse(latitude), double.parse(longitude)),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  // return Text("© OpenStreetMap contributors");
                  return Container();
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 100.0,
                    height: 100.0,
                    // point: latLng.LatLng(-7.4452562, 112.7052241),
                    point: latLng.LatLng(double.parse(latitude), double.parse(longitude)),
                    builder: (ctx) =>
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.location_pin,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              print('marker: clicked latitude ${latitude.toString()} longitude ${longitude.toString()} ');
                              launchMap(latitude, longitude, address);
                            },
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 16),
          color: Colors.black12,
          height: 1.5,
        ),
      ],
    );
  }

  void launchMap(
      String lat,
      String long,
      String title,
  ) async {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = TextButton(
      child: Text("Open"),
      onPressed:  () {
        // MapsLauncher.launchCoordinates(
        //     37.4220041, -122.0862462, 'Google Headquarters are here');
        MapsLauncher.launchCoordinates(
            double.parse(lat), double.parse(long), title);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Buka Maps"),
      content: Text("Lihat lokasi via Google Maps?"),
      actions: [
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildRelated(
      placeModel.PlaceModel? place
  ) {
    List<placeModel.Data> listPlace = [];
    if ( place != null ) {
      if (place.data.isNotEmpty) listPlace = place.data;
    }
    return Column(
      children: [
        Container (
          margin: EdgeInsets.only(top: 16.0),
          padding: EdgeInsets.all(8.0),
          child: Align (
            alignment: Alignment.centerLeft,
            child: Text( 'Tempat terdekat lainnya',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87 ),
            ),
          ),
        ),
        Container(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listPlace.length,
              itemBuilder: (context, position) {
                return Container(
                  child: Column (
                    children: [
                      Container(
                        width: 125.0,
                        height: 100.0,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/ragam_kuliner.jpg",
                            image: listPlace[position].image,
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
                      Container (
                        width: 100,
                        child: Text(
                          listPlace[position].name,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailBloc!,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text( '' ),
          elevation: 0.0,
        ),
        body: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {
            print('DetailView: state ${state.toString()}');
          },
          builder: (context, state) {
            if (state is DetailLoaded) {
              return Container (
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded (
                        child: SingleChildScrollView (
                          child: Column(
                            children: [
                              _buildPlace(
                                  state.placeDetailModel.data.image,
                                  state.placeDetailModel.data.name,
                              ),
                              _buildMenu(state.placeMenuModel),
                              _buildLocation(
                                state.placeDetailModel.data.address,
                                state.placeDetailModel.data.latitude,
                                state.placeDetailModel.data.longitude,
                              ),
                              _buildRelated(
                                state.placeModel
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              );
            } else if (state is DetailLoading) {
              return ProgressLoadingView();
            }
            return Container();
          },
        ),
      ),
    );
  }

}
