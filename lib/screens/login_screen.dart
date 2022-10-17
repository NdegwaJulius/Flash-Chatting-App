import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/components/components.dart';
import 'package:flutter_chatting_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatting_app/screens/chat_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  static String id ='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late  String email;
  late String password;
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(

        isLoading: _saving,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/BK.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email')
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password')
              ),

              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  color: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () async{
                    setState(() {
                      _saving = true;
                    });
                  try {

                   final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                   if(user != null) {
                     Navigator.pushNamed(context, ChatScreen.id);
                   }
                   setState(() {
                     _saving = true;
                   });
                  }
                  catch(e)  {
                    print(e);
                  }
    }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
