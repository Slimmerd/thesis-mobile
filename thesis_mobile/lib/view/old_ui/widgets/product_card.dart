import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/old_ui/screens/product_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/components/custom_counter.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final List<Product>? recommendations;
  final double pright;

  const ProductCard(
      {super.key,
      required this.product,
      this.pright = 10,
      this.recommendations});

  @override
  Widget build(BuildContext context) {
    final stockContext = BlocProvider.of<StockBloc>(context);
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);

    String productPrice = Money.fromInt(product.price, code: 'GBP')
        .format('#,###,###.00 S')
        .toString()
        .replaceAll(regexRemoveZero, '');

    num productVolume =
        product.volume >= 1000 ? product.volume / 1000 : product.volume;
    String volumeType = product.volume >= 1000
        ? volumeTypeParserBig(product.volumeType)
        : volumeTypeParserSmall(product.volumeType);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        CartBloc cart = context.read<CartBloc>();
        return GestureDetector(
          onTap: () => customPagePush(
              context,
              ProductScreen(
                product: product,
                recommendations:
                    recommendations ?? stockContext.state.randomFive,
              )),
          child: Container(
            height: 180,
            width: 105.w,
            margin: EdgeInsets.only(right: pright, bottom: 10),
            decoration: BoxDecoration(
                color: AppColors.cloud,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              SizedBox(
                height: 95,
                width: MediaQuery.of(context).size.width * 0.28,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    product.image,
                    cacheHeight: 256,
                    cacheWidth: 256,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productPrice,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.apply(color: AppColors.mintGreen)),
                    Text(
                      '${product.name}, $productVolume$volumeType',
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: state.has(product.id)
                      ? SizedBox(
                          width: 76,
                          child: CustomCounter(
                            height: 24,
                            quantity: state.count(product),
                            onChanged: (int quantity) {
                              if (quantity > 0) {
                                cart.updateQuantity(product.id, quantity);
                                taskContext.addLogTask(
                                    '[OLDUI][UPDATE] Cart product quantity: ${product.id}, pc: $quantity');
                              } else {
                                cart.removeFromCart(product.id);
                                taskContext.addLogTask(
                                    '[OLDUI][REMOVED] Cart product: ${product.id}');
                              }
                            },
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('More info',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.apply(
                                      decoration: TextDecoration.underline,
                                    )),
                            GestureDetector(
                                onTap: (() {
                                  cart.addToCart(CartProduct(
                                      product: product, quantity: 1));

                                  taskContext.addLogTask(
                                      '[OLDUI][ADDED] Cart product: ${product.id}');
                                }),
                                child: const Icon(Icons.add))
                          ],
                        ))
            ]),
          ),
        );
      },
    );
  }
}
