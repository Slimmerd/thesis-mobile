import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderContactBS extends StatelessWidget {
  final int orderID;

  const OrderContactBS({Key? key, required this.orderID}) : super(key: key);
//TODO FIX
  @override
  Widget build(BuildContext context) {
    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
          maxChildSize: 0.30,
          initialChildSize: 0.30,
          minChildSize: 0.30,
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
                    'Contact us',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () => launchUrlString(
                          'mailto:client@minado.ru?subject=Problem'),
                      child: Text(
                        'client@minado.ru',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ],
              ),
            );
          },
        ));
  }
}
