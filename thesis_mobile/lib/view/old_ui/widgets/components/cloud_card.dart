import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CloudCard extends StatelessWidget {
  final Widget child;

  const CloudCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.Cloud,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
        ),
        child: child);
  }
}
