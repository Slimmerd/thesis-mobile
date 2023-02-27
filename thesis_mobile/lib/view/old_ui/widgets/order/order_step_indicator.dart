import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class OrderStepIndicator extends StatelessWidget {
  final bool isCompleted;
  final bool isCurrent;

  const OrderStepIndicator(
      {Key? key, required this.isCompleted, required this.isCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 9,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: (() {
            if (isCurrent == true) {
              return const LinearProgressIndicator(
                color: AppColors.mintGreen,
                backgroundColor: AppColors.dorian,
              );
            } else if (isCompleted == true) {
              return const LinearProgressIndicator(
                value: 100,
                color: AppColors.mintGreen,
                backgroundColor: AppColors.dorian,
              );
            } else {
              return const LinearProgressIndicator(
                value: 0,
                color: AppColors.mintGreen,
                backgroundColor: AppColors.dorian,
              );
            }
          }())),
    );
  }
}
