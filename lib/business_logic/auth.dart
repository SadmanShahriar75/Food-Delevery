import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:food_delivery/ui/route/route.dart';
import 'package:food_delivery/ui/style/app_style.dart';
import 'package:get/get.dart';

class Auth {
  uploadImageToStroage(image, context, userName, email, password) async {
    try {
      AppStyles().progressDialog(context);
      File imageFile = File(image.path);
      FirebaseStorage stroage = FirebaseStorage.instance;
      UploadTask uploadTask =
          stroage.ref('profile-image').child(image.name).putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String imgUrl = await snapshot.ref.getDownloadURL();
      Get.back();
      registration(userName, email, password, imgUrl);
      print(imgUrl);
      print(userName);
      print(email);
      print(password);
    } catch (e) {
    
      Get.showSnackbar(AppStyles().failedSnackBar('Something is wrong'));
    }
  }


  registration(userName, email, password, imgUrl) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = credential.user;
      if (authCredential!.uid.isNotEmpty){
        
        CollectionReference reference = FirebaseFirestore.instance.collection('users');
        reference.doc(email).set({
          'email': email,
            'user_name': userName,
            'profile': imgUrl,
            'password': password,
        }).then((value) {
            Get.back();
        Get.showSnackbar(
          AppStyles().successSnackBar('Registration successful'));
        Get.toNamed(home);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.showSnackbar(AppStyles().failedSnackBar('The password provided is too weak'));
       
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.showSnackbar(AppStyles().successSnackBar('The account already exists for that email'));
        
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnackBar('Something is wrong'));
    }
  }


  login() {}


}
