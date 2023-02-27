import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/utils/colors.dart';

class AchievementCard extends StatelessWidget {
  final String image;
  final bool achieved;
  final String title;

  const AchievementCard({
    Key? key,
    required this.image,
    this.achieved = true,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 105.w,
      margin: const EdgeInsets.only(right: 0, bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.cloud,
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        SizedBox(
          height: 95,
          width: MediaQuery.of(context).size.width * 0.28,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: achieved
                ? Image.asset(
                    image,
                    cacheHeight: 324,
                    cacheWidth: 324,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    image,
                    cacheHeight: 324,
                    cacheWidth: 324,
                    fit: BoxFit.cover,
                    color: Colors.grey,
                    colorBlendMode: BlendMode.color,
                  ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ]),
    );
  }
}
