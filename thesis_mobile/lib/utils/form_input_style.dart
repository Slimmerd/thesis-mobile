import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

InputDecoration formInputStyle(String? label, [String? hint]) =>
    InputDecoration(
        labelText: '$label',
        hintText: hint != null ? hint : '',
        counterText: "",
        labelStyle: TextStyle(color: AppColors.Graphite, fontSize: 16),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        // floatingLabelStyle: ,
        filled: true,
        fillColor: AppColors.Dorian,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColors.GrayPick),
            borderRadius: BorderRadius.circular(15)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColors.MintGreen),
          borderRadius: BorderRadius.circular(15),
        ));
