import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStyles {
  progressDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              'assets/file/loading.gif',
              height: 150,
            ),
          );
        });
  }


//failed snackbar
  GetSnackBar failedSnackBar(message)=> GetSnackBar(
    message: message,
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 5),
    icon: Icon(Icons.warning),
  );

  //success snackbar
   GetSnackBar successSnackBar(message)=> GetSnackBar(
    message: message,
    backgroundColor: Colors.green,
    duration: Duration(seconds: 5),
    icon: Icon(Icons.done),
  );


}
