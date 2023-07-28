import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/app_string.dart';
import 'package:food_delivery/ui/route/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  await GetStorage.init();
  await Hive.initFlutter();
  Box box  = await Hive.openBox('contact-list');
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppString.app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Max',
      ),
      initialRoute: splash,
      getPages: getPages,
    );
  }
}
