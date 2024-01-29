import 'package:flutter/material.dart';
import 'package:matter_news/login_screen/Splash.dart';
import 'package:matter_news/core_functions/news_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.tinosTextTheme(),
      ),
      home: AnimatedSplashScreen(
            duration: 2000,
            splash: Splash(),
            nextScreen: NewsHome(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

}