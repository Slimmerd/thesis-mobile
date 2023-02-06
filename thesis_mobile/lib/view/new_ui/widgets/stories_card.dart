import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/typography.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 105.w,
      height: 135.h,

      // height: MediaQuery.of(context).size.height * 0.01,
      // width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          image: DecorationImage(
              image: AssetImage("assets/img1.jpeg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcOver)),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'How to reduce enviromental impact',
          style: NewTypography.R12700.apply(color: AppColors.Cloud),
        ),
      ),
    );
  }
}
