import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/view/new_ui/popups/delivery_popup.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/cloud_card.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    Key? key,
    required this.deliveryFeeString,
    required this.serviceFeeString,
    required this.cart,
  }) : super(key: key);

  final String deliveryFeeString;
  final String serviceFeeString;
  final CartBloc cart;

  double get progress {
    double progress = 0.0;

    if (cart.state.totalDeliveryPrice == 399) {
      progress = 0.1;
    }

    if (cart.state.totalDeliveryPrice == 199) {
      progress = 0.5;
    }

    if (cart.state.totalDeliveryPrice == 0) {
      progress = 1.0;
    }

    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const DeliveryPopup()),
      child: CloudCard(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery $deliveryFeeString',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$serviceFeeString service fee'),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          LinearProgressIndicator(
            value: progress,
            color: AppColors.mintGreen,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
