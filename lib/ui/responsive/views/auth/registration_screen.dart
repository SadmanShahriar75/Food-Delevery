import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/business_logic/auth.dart';
import 'package:food_delivery/ui/responsive/widgets/custom_button.dart';
import 'package:food_delivery/ui/responsive/widgets/custom_text_field.dart';
import 'package:food_delivery/ui/route/route.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  XFile? image;

  pickImageFromGallery() async {
    //pick an image.
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formkey,
          autovalidateMode: AutovalidateMode.always,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Create a new account.",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber, shape: BoxShape.circle),
                    child: image == null
                        ? Center(
                            child: IconButton(
                                onPressed: () => pickImageFromGallery(),
                                icon: Icon(Icons.camera)),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.fill,
                            )))),
            SizedBox(
              height: 10,
            ),
            customTextField(
              'Username',
              Icons.person_2_outlined,
              TextInputType.text,
              _userNameController,
              (val) {
                if (val!.isEmpty) {
                  return "field can't be empty";
                } else if (val.length < 4) {
                  return "field can't be less than five";
                }
              },
            ),
            customTextField(
              'email',
              Icons.mail_lock_outlined,
              TextInputType.emailAddress,
              _emailController,
              (val) {
                if (val!.isEmpty) {
                  return "field can't be empty";
                } else if (val.length < 5) {
                  return "field can't be less than five";
                }
              },
            ),
            customTextField('password', Icons.remove_red_eye_outlined,
                TextInputType.text, _passwordController, (val) {
              if (val!.isEmpty) {
                return "field can't be empty";
              } else if (val.length < 6) {
                return "password can't be less then 6 digit";
              }
            }, obscureText: true),
            SizedBox(
              height: 10,
            ),
            customButton(
              "Register Now",
              () {
                if (image == null) {
                  Get.snackbar('Warning', 'Please upload an image first');
                } else if (_formkey.currentState!.validate()) {
                  final userName = _userNameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  Auth().uploadImageToStroage(
                      image, context, userName, email, password, );
                      
                } else {
                  print("failed");
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Already have an account ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(login),
                      text: 'Login Now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ]),
        ),
      ),
    )));
  }
}
