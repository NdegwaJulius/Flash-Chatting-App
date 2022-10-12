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
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        WelcomeScreen.id: (context) => WelcomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        LoginScreen.id: (context) =>  LoginScreen(),
        RegistrationScreen.id: (context) =>  RegistrationScreen(),
        ChatScreen.id: (context) =>  ChatScreen(),
      },
    );
  }
}
