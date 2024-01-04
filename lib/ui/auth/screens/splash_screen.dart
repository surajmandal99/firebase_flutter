import 'package:firebase_tut/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Center(
              child: Text(
        "Splash Screen",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ))),
    );
  }
}
