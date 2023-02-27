import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';

class OrderProduct extends StatelessWidget {
  final CartProduct product;

  const OrderProduct({Key? key, required this.product}) : super(key: key);

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 75,
      decoration: BoxDecoration(
          color: AppColors.cloud,
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 75,
              height: 75,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
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
                  Text("${product.product.name}, $productVolume$volumeType",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.quantity} pc',
                        style: const TextStyle(
                            color: AppColors.grayPick,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        productPrice,
                        style: const TextStyle(
                            color: AppColors.mintGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
