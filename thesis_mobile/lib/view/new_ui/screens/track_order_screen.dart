import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/core/model/order_status.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/order_status_parser.dart';
import 'package:thesis_mobile/view/new_ui/popups/order_contact.dart';
import 'package:thesis_mobile/view/new_ui/widgets/order/order_step_indicator.dart';

class TrackOrderScreen extends StatelessWidget {
  final int orderID;

  const TrackOrderScreen({Key? key, required this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderContext = BlocProvider.of<OrderBloc>(context);
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] TrackOrderScreen $orderID');

    Order order = orderContext.state.itemById(orderID);
    final date = order.createdAt.add(Duration(minutes: order.waitingTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        actions: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const OrderContact(),
            ),
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.dangerous),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cloud,
                borderRadius: BorderRadius.circular(34),
                image: DecorationImage(
                    image: const AssetImage('assets/testmap.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.srcOver)),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
                ],
              ),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.dorian,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: const Text(
                    'Map tracking unavailable',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.graphite, fontSize: 14),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                children: [
                  Text(DateFormat('hh:mm').format(date.toLocal()),
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.graphite)),
                  const SizedBox(
                    width: 13,
                  ),
                  const Text('Waiting time')
                ],
              ),
            ),
            if (order.status != OrderStatus.rejected)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderStepIndicator(
                        isCompleted: order.status.index >
                            OrderStatus.waitingPayment.index,
                        isCurrent: order.status == OrderStatus.waitingPayment,
                      ),
                      OrderStepIndicator(
                        isCompleted: order.status.index >
                            OrderStatus.waitingWarehouse.index,
                        isCurrent: order.status == OrderStatus.waitingWarehouse,
                      ),
                      OrderStepIndicator(
                        isCompleted: order.status.index >
                            OrderStatus.acceptedWarehouse.index,
                        isCurrent:
                            order.status == OrderStatus.acceptedWarehouse,
                      ),
                      OrderStepIndicator(
                        isCompleted:
                            order.status.index > OrderStatus.delivering.index,
                        isCurrent: order.status == OrderStatus.delivering,
                      ),
                    ]),
              )
            else
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 9,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const LinearProgressIndicator(
                      value: 100,
                      color: AppColors.lightRed,
                      backgroundColor: AppColors.dorian,
                    )),
              ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                orderStatusParser(order.status),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.graphite),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Order № ${order.id}',
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
