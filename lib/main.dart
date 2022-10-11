import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/screens/chat_screen.dart';
import 'package:flutter_chatting_app/screens/login_screen.dart';
import 'package:flutter_chatting_app/screens/registration_screen.dart';
import 'package:flutter_chatting_app/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) =>  LoginScreen(),
        '/third': (context) =>  RegistrationScreen(),
        '/fourth': (context) =>  ChatScreen(),
      },
    );
  }
}
