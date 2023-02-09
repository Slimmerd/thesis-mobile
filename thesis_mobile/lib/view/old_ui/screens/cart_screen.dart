import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/default_data.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';
import 'package:thesis_mobile/view/old_ui/screens/checkout_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/cart/cart_product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String comment = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CartBloc, CartState>(builder: (cartCtx, state) {
      CartBloc cart = cartCtx.read<CartBloc>();

      final int deliveryCost = cart.state.totalDeliveryPrice;
      final int serviceFee = cart.state.serviceFee;
      final int totalPrice = cart.state.totalPrice + serviceFee + deliveryCost;

      final String totalPriceString = Money.fromInt(totalPrice, code: 'GBP')
          .format('#,###,###.00 S')
          .toString()
          .replaceAll(regexRemoveZero, '');

      return Scaffold(
        appBar: AppBar(title: Text('Cart'), actions: [
          IconButton(
              onPressed: () => cart.clearCart(), icon: Icon(Icons.delete))
        ]),
        body: cart.state.isEmpty
            ? Center(
                child: Text('Cart empty'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(padding: EdgeInsets.all(20), children: [
                      ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.items.length,
                          itemBuilder: (_, index) => CartProductCard(
                              product: state.item(index), cart: cart)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recommended for you',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: DefaultData.products.length,
                                  itemBuilder: (_, index) => ProductCard(
                                      product: DefaultData.products[index])),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Container(
                      // height: window.viewPadding.bottom + 105,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.Cloud,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${totalPriceString}',
                              style: Theme.of(context).textTheme.headline3),
                          ElevatedButton(
                            onPressed: () {
                              customPagePush(context, CheckoutScreen());
                            },
                            child: Text('К оплате'),
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
                      ))
                ],
              ),
      );
    });
  }
}
