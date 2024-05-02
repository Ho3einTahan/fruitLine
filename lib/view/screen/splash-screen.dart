import 'dart:async';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:fruitline/view/screen/hom-screen.dart';

import '../../core/const/appColor.dart';
import '../widget/fade-page-route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int index = 0;

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 2), // تغییر اینجا
      (timer) {
        setState(() {
          if (index < 1 && index >= 0) {
            index++;
          } else {
            index = 0;
            timer.cancel();
            Navigator.of(context).pushAndRemoveUntil(
              FadePageRoute(page: const HomeScreen()),
              (route) => false,
            );
          }
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSizeAndFade(
          fadeDuration: const Duration(seconds: 1),
          sizeDuration: const Duration(seconds: 1),
          alignment: Alignment.center,
          child: screens[index]),
    );
  }
}

List<Widget> get screens {
  return [
    firstScreen(),
    secondScreen(),
  ];
}

Widget firstScreen() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 32, top: 64, bottom: 20),
        child: Image.asset('images/avecado-icon.png', width: 150, height: 150),
      ),
      const Center(
        child: Text('فروش رسمی میوه به صورت آنلاین',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryGreen,
            )),
      ),
      const Spacer(),
      Image.asset('images/fruit-basket.png', height: 300, width: 300),
    ],
  );
}

Widget secondScreen() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.cover, image: AssetImage('images/splash-background.png')),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 42),
        Image.asset('images/avecado-icon.png', height: 150, width: 150),
        const SizedBox(height: 20),
        const Center(
          child: Text('پرداخت درب منزل',
              style: TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
