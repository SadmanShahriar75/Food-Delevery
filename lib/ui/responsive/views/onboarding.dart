import "package:flutter/material.dart";
import "package:food_delivery/ui/route/route.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:intro_screen_onboarding_flutter/introduction.dart";
import "package:intro_screen_onboarding_flutter/introscreenonboarding.dart";

class Onboarding extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Buy & Sell',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/image/onboarding1.jpg',
    ),
    Introduction(
      title: 'Delivery',
      subTitle: 'Your order will be immediately collected and',
      imageUrl: 'assets/image/onboarding2.jpg',
    ),
    Introduction(
      title: 'Receive Money',
      subTitle: 'Pick up delivery at your door and enjoy groceries',
      imageUrl: 'assets/image/onboarding3.jpg',
    ),
  ];

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroScreenOnboarding(
          backgroudColor: Colors.white,
          introductionList: list,
          onTapSkipButton: () {
            box.write('checked', true);
            Get.toNamed(login);
          }),
    );
  }
}
