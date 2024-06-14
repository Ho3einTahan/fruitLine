import 'package:flutter/material.dart';
import 'package:fruitline/core/class/model/cart.dart';
import 'package:fruitline/core/class/model/map.dart';
import 'package:fruitline/core/const/appColor.dart';
import 'package:fruitline/view/screen/detail-product-screen.dart';
import 'package:fruitline/view/screen/map-screen.dart';
import 'package:fruitline/view/screen/splash-screen.dart';
import 'package:fruitline/view/screen/vegetables-screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //
  Hive.registerAdapter(MapAdapter());
  Hive.registerAdapter(CartAdapter());
  //
  await Hive.openBox<Map>('map');
  await Hive.openBox<Cart>('cart');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          fillColor: AppColor.primaryPistachio.withOpacity(0.16),
          filled: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ProductDetail_Screen(),
    );
  }
}
