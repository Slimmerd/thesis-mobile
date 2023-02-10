import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/order/order_bloc.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/default_data.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/new_ui/screens/track_order_screen.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/pay_dropdown.dart';

class PayPopup extends StatefulWidget {
  final CartBloc cart;
  final String comment;

  const PayPopup({Key? key, required this.cart, required this.comment})
      : super(key: key);

  @override
  State<PayPopup> createState() => _PayPopupState();
}

class _PayPopupState extends State<PayPopup> {
  bool _isLoading = false;
  bool paymentDisabled = false;
  String payMethod = 'Card';

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    final addressContext = BlocProvider.of<AddressBloc>(context);
    final orderContext = BlocProvider.of<OrderBloc>(context);
    final int deliveryCost = widget.cart.state.totalDeliveryPrice;
    final int serviceFee = widget.cart.state.serviceFee;
    final int totalPrice =
        widget.cart.state.totalPrice + serviceFee + deliveryCost;
    final String totalPriceString = Money.fromInt(totalPrice, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

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
                            if (paymentDisabled == false &&
                                _isLoading == false) {
                              int orderID = orderContext.state.latestOrder + 1;
                              orderContext.addOrder(Order(
                                  id: orderID,
                                  address: Address(
                                    city: addressContext
                                        .state.currentAddress!.city,
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
                                  comment: widget.comment,
                                  ecoLevel: widget.cart.state.ecoLevel,
                                  deliveryType: widget.cart.state.deliveryType,
                                  serviceFee: serviceFee,
                                  total: totalPrice,
                                  createdAt: DateTime.now()));

                              //todo add achievemtns and stats

                              widget.cart.clearCart();
                              Navigator.pop(context);
                              customPagePush(
                                  context, TrackOrderScreen(orderID: orderID));
                            }
                          },
                          child: Text('Pay'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: paymentDisabled || _isLoading
                                  ? AppColors.Dorian
                                  : AppColors.MintGreen,
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
