import 'package:flutter/material.dart';
import 'package:kulineran/data/constant.dart';

class LoginRequiredView extends StatefulWidget {

  final VoidCallback callback;
  const LoginRequiredView({
    required this.callback,
    Key? key}) : super(key: key);

  @override
  State<LoginRequiredView> createState() => _LoginRequiredViewState();
}

class _LoginRequiredViewState extends State<LoginRequiredView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16,),
          Padding (
            padding: EdgeInsets.only(top: 4),
            child: Align (
              alignment: Alignment.center,
              child: Text(
                'Login is required',
                style: TextStyle(fontSize: 16, color: Colors.pink, fontWeight: FontWeight.normal ),
              ),
            ),
          ),
          SizedBox(height: 16,),
          Container(
            width: 225,
            child: MaterialButton(
                color: Colors.white,
                height: 50,
                shape: RoundedRectangleBorder (
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: Colors.pink,
                        style: BorderStyle.solid,
                        width: 2
                    )
                ),
                child: Text('Login', style: TextStyle (color: Colors.pink, fontSize: 18),),
                onPressed: () {
                  print('login: pressed');
                  Navigator.of(context).pushNamed(Constant.routeLogin)
                      .then((value){ widget.callback(); });
                }
            ),
          )
        ],
      ),
    );
  }
}
