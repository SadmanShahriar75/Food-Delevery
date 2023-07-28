import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import "package:food_delivery/ui/route/route.dart";

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();

  chooseScreen(context) {
    var value = box.read('checked');
    print(value);
    (value == true) ? Get.toNamed(home) : Get.toNamed(onboarding);

 
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () => chooseScreen(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/image/bibimbap.png',
          width: 200,
        ),
      ),
    );
  }
}
