import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/view/new_ui/popups/delivery_popup.dart';
import 'package:thesis_mobile/view/new_ui/screens/cart_screen.dart';

class OpenCartButton extends StatelessWidget {
  const OpenCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      CartBloc cart = context.read<CartBloc>();

      String price = Money.fromInt(cart.state.totalPrice, code: 'GBP')
          .format('#,###,###.00 S')
          .toString()
          .replaceAll(regexRemoveZero, '');

      String deliveryPrice =
          Money.fromInt(cart.state.totalDeliveryPrice, code: 'GBP')
              .format('#,###,###.00 S')
              .toString()
              .replaceAll(regexRemoveZero, '');

      String untilFreeDelivery = 1200 - cart.state.totalPrice > 0
          ? '${Money.fromInt(1200 - cart.state.totalPrice, code: 'GBP').format('#,###,###.00 S').toString().replaceAll(regexRemoveZero, '')} until free delivery'
          : 'free delivery';

      return Container(
        decoration: BoxDecoration(
            color: AppColors.cloud,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: -3,
                blurRadius: 8,
                offset: const Offset(0, -10), // changes position of shadow
              ),
            ]),
        height: (cart.state.notEmpty ? 107 : 45) +
            MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
            top: 10,
            bottom: 10 + MediaQuery.of(context).padding.bottom,
            left: 20,
            right: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const DeliveryPopup(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.local_taxi),
                  Text('Delivery $deliveryPrice · $untilFreeDelivery'),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
            ),
            if (cart.state.notEmpty)
              Column(
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      customPagePush(context, const CartScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mintGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        minimumSize: const Size(335, 53),
                        textStyle: const TextStyle(fontSize: 18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cart'),
                        Text(price),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      );
    });
  }
}
