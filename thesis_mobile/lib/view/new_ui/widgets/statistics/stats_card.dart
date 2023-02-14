import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class StatsCard extends StatelessWidget {
  final String image;
  final String title;

  const StatsCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 75,
      decoration: BoxDecoration(
          color: AppColors.Cloud,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 75,
              height: 75,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.asset(
                    image,
                    width: double.maxFinite,
                    fit: BoxFit.fill,
                    cacheWidth: 256,
                    cacheHeight: 256,
                  ))),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 14, top: 14, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
