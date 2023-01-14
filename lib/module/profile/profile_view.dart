import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/profile/profile_bloc.dart';
import 'package:kulineran/utils/widget/login_required_view.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';

class ProfileView extends StatefulWidget {

  final VoidCallback callback;
  const ProfileView({
    required this.callback,
    Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  ProfileBloc? profileBloc;

  @override
  void initState(){
    profileBloc = ProfileBloc(
      RepositoryProvider.of<UserRepository>(context),
    );
    profileBloc?.add(CheckLoginEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileBloc!,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          print('ProfileState: state $state');
          if (state is ProfileIsLogin) {
            profileBloc?.add(GetProfileEvent(state.token));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return ProgressLoadingView();
          } else if (state is ProfileIsNotLogin) {
            return FocusDetector(
                onFocusGained: () => profileBloc?.add(CheckLoginEvent()),
                child: LoginRequiredView( callback: () {
                  profileBloc?.add(CheckLoginEvent());
                })
            );
          } else if (state is ProfileLoaded) {
            return Container(
                height: double.infinity,
                color: Colors.white,
                child: SingleChildScrollView (
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            height: 150,
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/avatar_profile_fix.png",
                              image: "assets/avatar_profile_fix.png",
                              imageErrorBuilder: (context, error, stackTrace) => Image.asset("assets/avatar_profile_fix.png"),
                              fit: BoxFit.contain,
                            ),
                          )
                      ),
                      Padding (
                        padding: EdgeInsets.only(top: 4),
                        child: Align (
                          alignment: Alignment.center,
                          child: Text(
                            state.profileModel.name,
                            style: TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold ),
                          ),
                        ),
                      ),
                      Padding (
                        padding: EdgeInsets.only(top: 4),
                        child: Align (
                          alignment: Alignment.center,
                          child: Text(
                            state.profileModel.email,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        color: Colors.black12,
                        height: 0.5,
                      ),
                      InkWell(
                        onTap: () { widget.callback(); },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Align (
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'My Favorites',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                              Align (
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        height: 0.5,
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Align (
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Help',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ),
                              Align (
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        height: 0.5,
                      ),
                      InkWell(
                        onTap: () {
                          profileBloc?.add(UserLogoutEvent());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Align (
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Logout',
                                  style: TextStyle(fontSize: 14, color: Colors.black54 ),
                                ),
                              ),
                              Align (
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        height: 0.5,
                      ),
                    ],
                  ),
                )
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
