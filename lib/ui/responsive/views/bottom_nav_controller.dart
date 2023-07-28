import 'package:flutter/material.dart';
import 'package:food_delivery/ui/responsive/views/pages/bottom_card.dart';
import 'package:food_delivery/ui/responsive/views/pages/bottom_fav.dart';
import 'package:food_delivery/ui/responsive/views/pages/bottom_home.dart';
import 'package:food_delivery/ui/responsive/views/pages/bottom_profile.dart';

import 'package:food_delivery/ui/style/app_style.dart';
import 'package:get/get.dart';

class BottomNavController extends StatelessWidget {
  // const BottomNavController({super.key});

  final _pages = [
     BottomHome(),
     BottomFav(),
     BottomCard(),
     BottomProfile(),
  ];

  RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      bottomNavigationBar:
          BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.purple,
            currentIndex: _currentIndex.value, 
        
            onTap: (value) {

              _currentIndex.value = value;
            },
            items: [
        AppStyles.navItem(Icons.home_filled, 'Home'),
        AppStyles.navItem(Icons.favorite_outlined, 'Favourite'),
        AppStyles.navItem(Icons.person_2_outlined, 'Card'),
        AppStyles.navItem(Icons.person_2_outlined, 'Person'),
        
      ]),
      body: _pages[_currentIndex.value],
    )
    );
  }
}
