import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/ui/responsive/widgets/custom_button.dart';
import 'package:food_delivery/ui/responsive/widgets/custom_text_field.dart';
import 'package:food_delivery/ui/route/route.dart';
import 'package:get/get.dart';




class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                customTextField(
                  'email',
                  Icons.mail_outline,
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
                  "Login",
                  () {
                    if (_formkey.currentState!.validate()) {
                      Get.toNamed(home);
                      }else {
                        print("failed");
                      }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account ',
                    style: TextStyle(color: Colors.black),
                    children:  [
                      TextSpan(
                        recognizer: new TapGestureRecognizer()
                        ..onTap = () =>Get.toNamed(registration),
                          text: 'Create Now',
                          style: TextStyle(
                              color: Colors.blue,
                               fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
