import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/view/new_ui/popups/env_popup.dart';
import 'package:thesis_mobile/view/new_ui/widgets/cart/env_light.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/cloud_card.dart';

class EnvTipsCard extends StatelessWidget {
  const EnvTipsCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartBloc cart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const EnvPopup(),
      ),
      child: CloudCard(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Environmental tips',
            style: Theme.of(context).textTheme.headline3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  children: const [
                    SizedBox(
                      height: 5,
                    ),
                    Text('Order more items or choose delivery time slot'),
                  ],
                ),
              ),
              const Spacer(),
              EnvLight(
                metCriteria: cart.state.ecoLevel,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
