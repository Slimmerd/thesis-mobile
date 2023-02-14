import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/new_ui/popups/pay_popup.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/cart_product_card.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/delivery_card.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/env_tips_card.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] CartScreen');

    return BlocBuilder<CartBloc, CartState>(builder: (cartCtx, state) {
      CartBloc cart = cartCtx.read<CartBloc>();

      final int deliveryCost = cart.state.totalDeliveryPrice;
      final int serviceFee = cart.state.serviceFee;
      final int totalPrice = cart.state.totalPrice + serviceFee + deliveryCost;

      final String deliveryFeeString = Money.fromInt(deliveryCost, code: 'GBP')
          .format('#,###,###.00 S')
          .toString()
          .replaceAll(regexRemoveZero, '');

      final String serviceFeeString = Money.fromInt(serviceFee, code: 'GBP')
          .format('#,###,###.00 S')
          .toString()
          .replaceAll(regexRemoveZero, '');

      final String totalPriceString = Money.fromInt(totalPrice, code: 'GBP')
          .format('#,###,###.00 S')
          .toString()
          .replaceAll(regexRemoveZero, '');

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: [
            IconButton(
                onPressed: () => cart.clearCart(), icon: Icon(Icons.delete))
          ],
        ),
        body: cart.state.isEmpty
            ? Center(
                child: Text('Cart empty'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(padding: EdgeInsets.all(20), children: [
                      DeliveryCard(
                          deliveryFeeString: deliveryFeeString,
                          serviceFeeString: serviceFeeString,
                          cart: cart),
                      EnvTipsCard(cart: cart),
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.items.length,
                          itemBuilder: (_, index) => CartProductCard(
                              product: state.item(index), cart: cart)),
                    ]),
                  ),
                  Container(
                      // height: window.viewPadding.bottom + 105,
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 10 + MediaQuery.of(context).padding.bottom),
                      decoration: BoxDecoration(
                          color: AppColors.Cloud,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Graphite)),
                              Text('${totalPriceString}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.Graphite)),
                            ],
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => PayPopup(
                                  cart: cart,
                                ),
                              );
                            },
                            child: Text('Checkout'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.MintGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34.0),
                                ),
                                elevation: 0,
                                minimumSize: Size(335, 53),
                                textStyle: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ))
                ],
              ),
      );
    });
  }
}
