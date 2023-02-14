import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/old_ui/screens/track_order_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/components/cloud_card.dart';
import 'package:thesis_mobile/view/old_ui/widgets/cart/pay_dropdown.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  String comment = '';
  bool paymentDisabled = false;
  String payMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    final addressContext = BlocProvider.of<AddressBloc>(context);
    final orderContext = BlocProvider.of<OrderBloc>(context);
    final cartContext = BlocProvider.of<CartBloc>(context);
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] CheckoutScreen');

    final int subTotal = cartContext.state.totalPrice;
    final int deliveryFee = cartContext.state.totalDeliveryPrice;
    final int serviceFee = cartContext.state.serviceFee;
    final int totalPrice = subTotal + serviceFee + deliveryFee;

    final String subTotalString = Money.fromInt(subTotal, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

    final String deliveryFeeString = Money.fromInt(deliveryFee, code: 'GBP')
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
        title: Text('Checkout'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Delivery address',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 10,
          ),
          CloudCard(
            child: Text(
              '${addressContext.state.currentAddress?.street} ${addressContext.state.currentAddress?.building}',
              style: NewTypography.M16400,
            ),
          ),
          Text(
            'Comment',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 10,
          ),
          CloudCard(
              child: TextFormField(
            key: _formKey,
            decoration: formInputStyle(''),
            minLines: 1,
            maxLines: 2,
            maxLength: 100,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String? value) {
              setState(() => comment = value!);
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          )),
          Text(
            'Order summary',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 10,
          ),
          CloudCard(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text('$subTotalString'),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery fee',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text('$deliveryFeeString'),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service fee',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text('$serviceFeeString'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '$totalPriceString',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.apply(color: AppColors.MintGreen),
                  ),
                ],
              ),
            ],
          )),
          Text(
            'Payment method',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            // height: 80,
            child: CloudCard(
              child: PayDrodown(
                payMethod: payMethod,
                callback: (String dropdownValue) {
                  setState(() => payMethod = dropdownValue);
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (paymentDisabled == false) {
                int orderID = orderContext.state.latestOrder + 1;
                orderContext.addOrder(Order(
                    id: orderID,
                    address: Address(
                      city: addressContext.state.currentAddress!.city,
                      building: addressContext.state.currentAddress!.building,
                      street: addressContext.state.currentAddress!.street,
                      intercom: addressContext.state.currentAddress!.intercom,
                      flatNumber:
                          addressContext.state.currentAddress!.flatNumber,
                      floor: addressContext.state.currentAddress!.floor,
                    ),
                    products: cartContext.state.items,
                    subTotal: subTotal,
                    deliveryPrice: deliveryFee,
                    comment: comment,
                    ecoLevel: cartContext.state.ecoLevel,
                    deliveryType: cartContext.state.deliveryType,
                    serviceFee: serviceFee,
                    total: totalPrice,
                    createdAt: DateTime.now()));

                taskContext.addOrderTask();
                taskContext.addLogTask('[OLDUI][ADDED] Order $orderID');

                cartContext.clearCart();
                Navigator.pop(context);
                customPagePush(context, TrackOrderScreen(orderID: orderID));
              }
            },
            child: Text('Pay $totalPriceString'),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.MintGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                elevation: 0,
                minimumSize: Size(135, 53),
                textStyle: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
