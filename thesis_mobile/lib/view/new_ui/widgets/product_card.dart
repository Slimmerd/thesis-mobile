import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/new_ui/popups/product_popup.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double pright;

  const ProductCard({super.key, required this.product, this.pright = 10});

  @override
  Widget build(BuildContext context) {
    String productPrice = Money.fromInt(product.price, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

    num productVolume =
        product.volume >= 1000 ? product.volume / 1000 : product.volume;
    String volumeType = product.volume >= 1000
        ? volumeTypeParserBig(product.volumeType)
        : volumeTypeParserSmall(product.volumeType);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => ProductBottomSheet(
          product: product,
        ),
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.25,
        // width: MediaQuery.of(context).size.width * 0.28,
        height: 180,
        width: 105.w,
        margin: EdgeInsets.only(right: pright, bottom: 10),
        decoration: BoxDecoration(
            color: AppColors.Cloud,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          SizedBox(
            height: 95,
            width: MediaQuery.of(context).size.width * 0.28,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5.r,
                ),
                Text(
                  '${productVolume}${volumeType}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.r),
            child: Text('${productPrice}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.apply(color: AppColors.MintGreen)),
          )
        ]),
      ),
    );
  }
}
