import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';

class MerchantAppBar extends StatefulWidget {
  const MerchantAppBar({Key? key}) : super(key: key);

  @override
  State<MerchantAppBar> createState() => _MerchantAppBarState();
}

class _MerchantAppBarState extends State<MerchantAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 40 + MediaQuery.of(context).padding.top),
      color: AppColors.Dorian,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'widget.merchantInfo.name,',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: AppColors.Graphite),
          ),
        ],
      ),
    );
  }
}
