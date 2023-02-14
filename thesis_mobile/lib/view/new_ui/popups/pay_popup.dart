import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/default_data.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/new_ui/screens/track_order_screen.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/pay_dropdown.dart';

class PayPopup extends StatefulWidget {
  final CartBloc cart;

  const PayPopup({Key? key, required this.cart}) : super(key: key);

  @override
  State<PayPopup> createState() => _PayPopupState();
}

class _PayPopupState extends State<PayPopup> {
  String payMethod = 'Card';
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  String comment = '';

  @override
  Widget build(BuildContext context) {
    final addressContext = BlocProvider.of<AddressBloc>(context);
    final orderContext = BlocProvider.of<OrderBloc>(context);
    final statsContext = BlocProvider.of<StatisticsBloc>(context);
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);

    final int deliveryCost = widget.cart.state.totalDeliveryPrice;
    final int serviceFee = widget.cart.state.serviceFee;
    final int totalPrice =
        widget.cart.state.totalPrice + serviceFee + deliveryCost;
    final String totalPriceString = Money.fromInt(totalPrice, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

    taskContext.addLogTask('[NEWUI][OPENED] PayPopup');

    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.50,
        maxChildSize: 0.50,
        minChildSize: 0.45,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration: BoxDecoration(
                color: AppColors.Cloud,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    controller: scrollController,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${addressContext.state.currentAddress!.street} ${addressContext.state.currentAddress!.building}',
                              style: TextStyle(
                                  color: AppColors.Graphite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Text(
                                'Order will be delivered in ' +
                                    '~${DefaultData.waitingTime}-${(DefaultData.waitingTime * 1.5).ceil()} min',
                                style: TextStyle(color: AppColors.GrayPick)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: PayDrodown(
                          payMethod: payMethod,
                          callback: (String dropdownValue) {
                            setState(() => payMethod = dropdownValue);
                          },
                        ),
                      ),
                      TextFormField(
                        key: _formKey,
                        decoration: formInputStyle('Comment'),
                        minLines: 2,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (String? value) {
                          setState(() => comment = value!);
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 10 + MediaQuery.of(context).padding.bottom),
                    child: Column(children: [
                      Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${totalPriceString}',
                              style: TextStyle(
                                  color: AppColors.Graphite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${DefaultData.waitingTime}-${(DefaultData.waitingTime * 1.5).ceil()} min'),
                          ],
                        ),
                        SizedBox(width: 35),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            int orderID = orderContext.state.latestOrder + 1;
                            Order newOrder = Order(
                                id: orderID,
                                address: Address(
                                  city:
                                      addressContext.state.currentAddress!.city,
                                  building: addressContext
                                      .state.currentAddress!.building,
                                  street: addressContext
                                      .state.currentAddress!.street,
                                  intercom: addressContext
                                      .state.currentAddress!.intercom,
                                  flatNumber: addressContext
                                      .state.currentAddress!.flatNumber,
                                  floor: addressContext
                                      .state.currentAddress!.floor,
                                ),
                                products: widget.cart.state.items,
                                subTotal: widget.cart.state.totalPrice,
                                deliveryPrice: deliveryCost,
                                comment: comment,
                                ecoLevel: widget.cart.state.ecoLevel,
                                deliveryType: widget.cart.state.deliveryType,
                                deliveryWindow:
                                    widget.cart.state.deliveryWindow,
                                serviceFee: serviceFee,
                                total: totalPrice,
                                createdAt: DateTime.now());
                            orderContext.addOrder(newOrder);
                            // achievemtns and stats
                            statsContext.addOrder(newOrder);
                            taskContext.addOrderTask();
                            taskContext
                                .addLogTask('[NEWUI][ADDED] Order $orderID');

                            widget.cart.clearCart();
                            Navigator.pop(context);
                            customPagePush(
                                context, TrackOrderScreen(orderID: orderID));
                          },
                          child: Text('Pay'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.MintGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              maximumSize: Size(221, 55),
                              minimumSize: Size(150, 55),
                              textStyle: TextStyle(fontSize: 18)),
                        ))
                      ])
                    ]))
              ]));
        },
      ),
    );
  }
}
