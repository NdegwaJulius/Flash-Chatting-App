import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/components/components.dart';
import 'package:flutter_chatting_app/screens/login_screen.dart';
import 'package:flutter_chatting_app/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id ='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller  =AnimationController(
      vsync: this,

      duration: const Duration(seconds: 3),
    );
    animation = ColorTween(begin: Colors.grey,end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {

      });
      print(animation.value);
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Row(
              children: <Widget>[
                Flexible(

                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/BK.png'),
                      height:60.0,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat App'],
                  textStyle: const TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


