import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/home');
    });

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Image.asset("asset/images/plant-removebg-preview.png",scale: 1.4,),
            Text("Plantify",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 30

            ),),
            SizedBox(height: 20,),

            CircularProgressIndicator(),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.19,
            )
          ],
        ),
        ),

      );

  }
}
