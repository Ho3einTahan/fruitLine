import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruitline/view/screen/hom-screen.dart';

import '../../core/const/appColor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), // تغییر اینجا
        (timer) {
      timer.cancel();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryGreen,
      body: Center(
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
