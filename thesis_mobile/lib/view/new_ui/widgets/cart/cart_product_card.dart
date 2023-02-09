import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/custom_counter.dart';

class CartProductCard extends StatelessWidget {
  final CartProduct product;
  final CartBloc cart;

  const CartProductCard({Key? key, required this.product, required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 75,
      decoration: BoxDecoration(
          color: AppColors.Cloud,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 75,
              height: 75,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
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
                  Text("${product.product.name}",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Graphite,
                      )),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${productPrice}',
                        style: TextStyle(
                            color: AppColors.MintGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${productVolume} ${volumeType}',
                        style: TextStyle(
                            color: AppColors.GrayPick,
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
                } else {
                  cart.removeFromCart(product.product.id);
                }
              },
              quantity: cart.state.count(product.product)),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
