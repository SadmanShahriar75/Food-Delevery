
import 'package:food_delivery/ui/responsive/views/auth/login_screen.dart';
import 'package:food_delivery/ui/responsive/views/auth/registration_screen.dart';
import 'package:food_delivery/ui/responsive/views/bottom_nav_controller.dart';
import 'package:food_delivery/ui/responsive/views/onboarding.dart';
import 'package:food_delivery/ui/responsive/views/splash.dart';
import 'package:get/route_manager.dart';

import '../responsive/views/pages/details_screen.dart';

const String splash = '/splash';
const String onboarding = '/onboarding';
const String login = '/login';
const String registration = '/registration';
const String home = '/home';
const String details = '/details';


List <GetPage> getPages = [
  GetPage(name: splash, page: ()=> Splash()),
  GetPage(name: onboarding, page: ()=> Onboarding()),
  GetPage(name: login, page: ()=> LoginScreen()),
  GetPage(name: registration, page: ()=> RegistrationScreen()),
  GetPage(name: home, page: ()=> BottomNavController()),
  GetPage(name: details, page: ()=> DetailsScreen(
    data: Get.arguments,
  )),

  // GetPage(name: , page: page)
];
