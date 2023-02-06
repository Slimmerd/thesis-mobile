import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/typography.dart';

class EnvPopup extends StatelessWidget {
  const EnvPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
          maxChildSize: 0.50,
          initialChildSize: 0.45,
          minChildSize: 0.40,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.Cloud,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: ListView(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                children: [
                  Text(
                    'Environmental tips',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Our delivery service is focused on reducing environmental impact and promoting responsible consumption',
                    style: NewTypography.M16400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To reduce your environmental impact you can order more food in one order or choose a more environmentally friendly delivery method ',
                    style: NewTypography.M16400,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      '* for better result, you can meet both of these conditions',
                      style: NewTypography.M14400.apply(
                        color: AppColors.GrayPick,
                      ))
                ],
              ),
            );
          },
        ));
  }
}
