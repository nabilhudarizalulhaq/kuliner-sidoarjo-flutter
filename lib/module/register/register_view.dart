import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/register/register_bloc.dart';
import 'package:kulineran/utils/helper_utils.dart' as helper;
import 'package:kulineran/utils/widget/progress_loading_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  RegisterBloc? _registerBloc;

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userPasswordConfirmation = '';

  @override
  void initState(){
    _registerBloc = RegisterBloc(
      RepositoryProvider.of<UserRepository>(context),
    );
    super.initState();
  }

  Widget setButton(){
    return Container(
      width: double.infinity,
      child: MaterialButton(
        color: Colors.pink,
          height: 50,
          shape: RoundedRectangleBorder (
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('Register', style: TextStyle (color: Colors.white, fontSize: 18),),
          onPressed: () {
            if(userName.isEmpty) {
              helper.toastMessage(context, 'Name is required');
            } else if(userEmail.isEmpty) {
              helper.toastMessage(context, 'Email is required');
            } else if(userPassword.isEmpty) {
              helper.toastMessage(context, 'Password is required');
            } else if(userPassword != userPasswordConfirmation) {
              helper.toastMessage(context, 'Password Confirmation is not valid');
            } else {
              _registerBloc?.add(
                  UserRegisterEvent(
                      userName,
                      userEmail,
                      userPassword,
                      userPasswordConfirmation
                  )
              );
            }
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _registerBloc!,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if(state is RegisterLoaded) {
                helper.toastMessage(context, 'Successfully Registered');
                // Navigator.of(context)
                //     .pushReplacementNamed(Constant.routeLogin);
                Navigator.of(context).pop();
              } else if(state is RegisterNotLoaded) {
                helper.toastMessage(context, state.message);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView (
                child:  Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/kober_mie_setan.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 250.0,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding (
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Register.',
                                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration (
                          border: UnderlineInputBorder (),
                          labelText: 'Name',
                        ),
                        onChanged: (String text){
                          userName = text;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: TextFormField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration (
                          border: UnderlineInputBorder (),
                          labelText: 'Email',
                        ),
                        onChanged: (String text){
                          userEmail = text;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration (
                          border: UnderlineInputBorder (),
                          labelText: 'Password',
                        ),
                        onChanged: (String text){
                          userPassword = text;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 16),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration (
                          border: UnderlineInputBorder (),
                          labelText: 'Confirm Password',
                        ),
                        onChanged: (String text){
                          userPasswordConfirmation = text;
                        },
                      ),
                    ),
                    Container (
                      margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                      // child: isLoading ? setLoading() : setButton(),
                      child: state is RegisterLoading ? ProgressLoadingView(): setButton(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Have an account?",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16, color: Colors.pink, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            onTap: (){
                              Navigator.of(context)
                                  .pushReplacementNamed(Constant.routeLogin);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
        ),
      ),
    );
  }
}
