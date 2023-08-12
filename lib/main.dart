import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'navigator/tab_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { // build方法
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen,
    );
  }
}

Widget splashScreen = AnimatedSplashScreen(
  splash: Image.asset('assets/splash.jpg'),
  nextScreen: TabNavigator(),
  splashTransition: SplashTransition.fadeTransition,
  backgroundColor: Colors.white,
  duration: 3000,
);
