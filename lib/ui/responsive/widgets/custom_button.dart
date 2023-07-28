import 'package:flutter/material.dart';
import 'package:food_delivery/const/app_colors.dart';

Widget customButton(title, onTap) {
  return InkWell(
    onTap: onTap,
    splashColor: Colors.white,
    borderRadius: BorderRadius.circular(8),
    child: Ink(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.amber),
      child: Center(
        child: Text(title),
      ),
    ),
  );
}
