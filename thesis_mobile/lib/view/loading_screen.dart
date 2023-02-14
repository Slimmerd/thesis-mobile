import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.MintGreen,
              ),
            )));
  }
}
