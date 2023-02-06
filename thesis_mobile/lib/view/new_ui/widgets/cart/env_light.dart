import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class EnvLight extends StatelessWidget {
  final int metCriteria;

  const EnvLight({super.key, this.metCriteria = 0});

  @override
  Widget build(BuildContext context) {
    const List<Widget> stateIcons = [
      Icon(
        Icons.close,
        color: AppColors.RedWarn,
      ),
      Icon(
        Icons.done,
        color: AppColors.YellowWarn,
      ),
      Icon(
        Icons.done_all,
        color: AppColors.MintGreen,
      )
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.Dorian,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
        ],
      ),
      child: stateIcons[metCriteria],
    );
  }
}
