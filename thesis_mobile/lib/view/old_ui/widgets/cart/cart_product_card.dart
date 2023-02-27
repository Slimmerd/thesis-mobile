import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/old_ui/widgets/components/custom_counter.dart';

class CartProductCard extends StatelessWidget {
  final CartProduct product;
  final CartBloc cart;

  const CartProductCard({Key? key, required this.product, required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    var productPrice = Money.fromInt(product.totalPrice, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');
    var productVolume = product.product.volume >= 1000
        ? product.product.volume / 1000
        : product.product.volume;
    var volumeType = product.product.volume >= 1000
        ? volumeTypeParserBig(product.product.volumeType)
        : volumeTypeParserSmall(product.product.volumeType);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 75,
      decoration: BoxDecoration(
          color: AppColors.cloud,
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 75,
              height: 75,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14)),
                  child: Image.asset(
                    product.product.image,
                    width: double.maxFinite,
                    fit: BoxFit.fill,
                    cacheWidth: 256,
                    cacheHeight: 256,
                  ))),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 14, top: 14, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.product.name,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.graphite,
                      )),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        productPrice,
                        style: const TextStyle(
                            color: AppColors.mintGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$productVolume $volumeType',
                        style: const TextStyle(
                            color: AppColors.grayPick,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          CustomCounter(
              height: 35,
              onChanged: (int quantity) {
                if (quantity > 0) {
                  cart.updateQuantity(product.product.id, quantity);
                  taskContext.addLogTask(
                      '[OLDUI][UPDATED] CartProduct ${product.product.id}, pc: $quantity');
                } else {
                  cart.removeFromCart(product.product.id);
                  taskContext.addLogTask(
                      '[OLDUI][REMOVED] CartProduct ${product.product.id}');
                }
              },
              quantity: cart.state.count(product.product)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
