import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/model/home_menu_model.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/favorite/favorite_view.dart';
import 'package:kulineran/module/home/home_bloc.dart';
import 'package:kulineran/module/home/home_view.dart';
import 'package:kulineran/module/profile/profile_view.dart';

class BaseHomeView extends StatefulWidget {
  const BaseHomeView({Key? key}) : super(key: key);

  @override
  _BaseHomeViewState createState() => _BaseHomeViewState();
}

class _BaseHomeViewState extends State<BaseHomeView> {

  int _menuSelected = 0;
  HomeMenu _homeMenu = HomeMenu.placeSelected;
  bool _isSearch = false;
  String keyword = '';

  TextEditingController _searchQueryController = TextEditingController();

  AppBar _buildToolbar(){
    return AppBar(
      title: Text( 'Kuliner Sidoarjo' ),
      actions: _homeMenu == HomeMenu.placeSelected
          ? <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigator.of(context).pushNamed(Constant.routeSearch);
            setState(() {
              _isSearch = true;
            });
          },
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.filter_alt,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(Constant.routeFilter);
        //   },
        // )
      ] : <Widget>[],
    );
  }

  AppBar _buildToolbarSearch(){
    return AppBar(
      backgroundColor: Colors.white,
      title: TextField(
        cursorColor: Colors.black54,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          setState(() { keyword = value; });
        },
        decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              color: Color.fromRGBO(93, 25, 72, 1),
              onPressed: () {
                setState(() {
                  _isSearch = false;
                  keyword = '';
                });
              },
            )
        ),
        style: TextStyle(
            color: Colors.black54,
            fontSize: 18
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearch ? _buildToolbarSearch() :  _buildToolbar(),
      body: _buildContainerView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _menuSelected,
        selectedItemColor: Colors.pink,
        onTap: _onMenuTapped,
      ),
    );
  }

  void _onMenuTapped(int index) {
    setState(() {
      _menuSelected = index;
      switch(_menuSelected) {
        case 0:
          _homeMenu = HomeMenu.placeSelected;
          break;
        case 1:
          _homeMenu = HomeMenu.favoriteSelected;
          break;
        case 2:
          _homeMenu = HomeMenu.profileSelected;
          break;
      }
    });
  }

  Widget _buildContainerView(){
    if(_homeMenu == HomeMenu.placeSelected) {
      // return HomeView(homeBloc: homeBloc);
      return HomeView(keyword: keyword);
    } else if(_homeMenu == HomeMenu.favoriteSelected) {
      return FavoriteView();
    } else if(_homeMenu == HomeMenu.profileSelected) {
      return ProfileView(callback: () => _onMenuTapped(1),);
    } else {
      return Container();
    }
  }

}

