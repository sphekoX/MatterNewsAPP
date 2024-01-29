import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    startTimer();
  }

  startTimer(){
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }
  route(){ if (mounted) {
    Navigator.pushReplacementNamed(context, '/news_home.dart');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color.fromARGB(255, 49, 44, 255),
      body: content(),  
    );
  }
  
  content() {
    return Center(
       child: SizedBox(
      width: double.infinity,
      //height: double.infinity,
      child: Image.asset('assets/splash.jpg', fit: BoxFit.cover),
    ),
    );
  }
}