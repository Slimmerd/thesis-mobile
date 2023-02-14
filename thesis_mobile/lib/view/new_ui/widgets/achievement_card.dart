import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/utils/colors.dart';

class AchievementCard extends StatelessWidget {
  final String image;
  final String title;

  const AchievementCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 105.w,
      margin: EdgeInsets.only(right: 0, bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.Cloud,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        SizedBox(
          height: 95,
          width: MediaQuery.of(context).size.width * 0.28,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            '${title}',
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ]),
    );
  }
}
