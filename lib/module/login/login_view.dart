import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulineran/data/constant.dart';
import 'package:kulineran/data/repository/user_repository.dart';
import 'package:kulineran/module/login/login_bloc.dart';
import 'package:kulineran/utils/widget/progress_loading_view.dart';
import 'package:kulineran/utils/helper_utils.dart' as helper;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginBloc? loginBloc;

  String userEmail = 'asdf@gmail.com';
  String userPassword = 'qwertyui';

  @override
  void initState() {
    loginBloc = LoginBloc(
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
          child: Text('Login', style: TextStyle (color: Colors.white, fontSize: 18),),
          onPressed: () {
            loginBloc?.add(
                UserLoginEvent(userEmail, userPassword)
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc!,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            print('LoginState: state ${state.toString()}');
            if(state is LoginLoaded) {
              helper.toastMessage( context, 'Login Successfully' );
              Navigator.of(context).pop();
            } else if(state is LoginNotLoaded) {
              helper.toastMessage( context, state.message );
            }
          },
          builder: (context, state) {
            return Padding (
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView (
                child:  Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.30,
                    // ),
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
                                'Login.',
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
                          labelText: 'Email',
                        ),
                        onChanged: (String text){
                          userEmail = text;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24, right: 24, top: 8),
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
                    Container (
                      margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                      // child: isLoading ? setLoading() : setButton(),
                      child: state is LoginLoading ? ProgressLoadingView() : setButton(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.all(5),
                          child: InkWell(
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 16, color: Colors.pink, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            onTap: (){
                              Navigator.of(context)
                                  .pushReplacementNamed(Constant.routeRegister);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
