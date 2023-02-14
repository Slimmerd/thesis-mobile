import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/core/model/order_status.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/order_status_parser.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/old_ui/popups/order_contact.dart';
import 'package:thesis_mobile/view/old_ui/popups/order_review_popup.dart';
import 'package:thesis_mobile/view/old_ui/screens/track_order_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/components/cloud_card.dart';
import 'package:thesis_mobile/view/old_ui/widgets/order/order_product_card.dart';

class OrderScreen extends StatelessWidget {
  final Order order;

  const OrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] Order ${order.id}');

    var subTotal = Money.fromInt(order.subTotal, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');
    var deliveryPrice = Money.fromInt(order.deliveryPrice, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');
    var serviceFee = Money.fromInt(order.serviceFee, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');
    var totalPrice = Money.fromInt(order.total, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
        actions: [
          IconButton(
              onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => OrderContact(),
                  ),
              icon: Icon(Icons.report_problem))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          //  Status (Delivered etc and date)
          CloudCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat('yyyy-MM-dd HH:mm:ss').format(order.createdAt.toLocal())}',
                  style: NewTypography.R10500,
                ),
                Text('${orderStatusParser(order.status)}',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${order.address.street} ${order.address.building}',
                  style: NewTypography.M12400,
                ),
              ],
            ),
          ),

          if (order.comment != null && order.comment.isNotEmpty)
            CloudCard(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Comment',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  Text(
                    order.comment,
                  ),
                ])),

          if (order.status != OrderStatus.rejected &&
              order.status != OrderStatus.delivered)
            CloudCard(
              child: ElevatedButton(
                  onPressed: () => customPagePush(
                      context,
                      TrackOrderScreen(
                        orderID: order.id,
                      )),
                  child: Text('Track'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.MintGreen,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(14.0),
                      ),
                      elevation: 0,
                      minimumSize: Size(210, 48),
                      maximumSize: Size(225, 53),
                      textStyle: TextStyle(fontSize: 18))),
            ),

          if (order.status == OrderStatus.delivered && order.review == null)
            CloudCard(
                child: ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => OrderReview(
                            orderID: order.id,
                          ),
                        ),
                    child: Text('Leave review'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.MintGreen,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(14.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(210, 48),
                        maximumSize: Size(225, 53),
                        textStyle: TextStyle(fontSize: 18)))),

          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: order.products.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderProduct(
                product: order.products[index],
              );
            },
          ),

          CloudCard(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total', style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub total',
                      style: NewTypography.R12600,
                    ),
                    Text(
                      '${subTotal}',
                      style: NewTypography.R12400,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery',
                      style: NewTypography.R12600,
                    ),
                    Text(
                      '${deliveryPrice}',
                      style: NewTypography.R12400,
                    ),
                  ],
                ),
              ),
              //  Service
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service', style: NewTypography.R12600),
                    Text(
                      '${serviceFee}',
                      style: NewTypography.R12400,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: NewTypography.R12600),
                    Text('${totalPrice}',
                        style: NewTypography.R12400.apply(
                          color: AppColors.MintGreen,
                        )),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
