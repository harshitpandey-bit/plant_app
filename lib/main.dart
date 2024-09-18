import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/screens/cart_screen.dart';
import 'package:plant/screens/home_screen.dart';
import 'package:plant/screens/splash_screen.dart';
import 'package:plant/service/plant_service.dart';
import 'controller/cart_controller.dart';
import 'controller/home_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PlantService());
  Get.put(CartController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Plant Identification',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/cart': (context)=> CartScreen()

      },

      initialRoute: '/splash', // Start with the SplashScreen

    );
  }
}
