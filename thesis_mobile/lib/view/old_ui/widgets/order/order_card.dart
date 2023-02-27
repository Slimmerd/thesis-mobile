import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/order_status_parser.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/old_ui/screens/order_screen.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var price = Money.fromInt(order.total, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');
    var orderStatus = orderStatusParser(order.status);
    var orderDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(order.createdAt.toLocal());

    return GestureDetector(
      onTap: () {
        customPagePush(context, OrderScreen(order: order));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.cloud,
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(orderDate,
                      style:
                          const TextStyle(color: AppColors.grayPick, fontSize: 10)),
                  const SizedBox(height: 10),
                  Text('Order #${order.id}',
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.graphite)),
                  const SizedBox(height: 5),
                  Text(orderStatus,
                      style:
                          const TextStyle(color: AppColors.grayPick, fontSize: 12)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 20),
              alignment: Alignment.center,
              child: Text(price,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mintGreen)),
            ),
          ],
        ),
      ),
    );
  }
}
