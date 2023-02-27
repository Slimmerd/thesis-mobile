import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

InputDecoration formInputStyle(String? label, [String? hint]) =>
    InputDecoration(
        labelText: '$label',
        hintText: hint ?? '',
        counterText: "",
        labelStyle: const TextStyle(color: AppColors.graphite, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        // floatingLabelStyle: ,
        filled: true,
        fillColor: AppColors.dorian,
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColors.grayPick),
            borderRadius: BorderRadius.circular(15)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: AppColors.mintGreen),
          borderRadius: BorderRadius.circular(15),
        ));
