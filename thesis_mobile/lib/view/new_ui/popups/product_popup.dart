import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/new_ui/widgets/components/custom_counter.dart';

class ProductBottomSheet extends StatefulWidget {
  final Product product;

  const ProductBottomSheet({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] ProductPopup ${widget.product.id}');

    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
          initialChildSize: 0.95,
          maxChildSize: 0.95,
          minChildSize: 0.9,
          builder:
              (BuildContext buildContext, ScrollController scrollController) {
            return BlocBuilder<CartBloc, CartState>(
              builder: (cartContext, cartState) {
                CartBloc cart = cartContext.read<CartBloc>();
                var inCartPrice = Money.fromInt(
                        cartState.productTotal(widget.product),
                        code: 'GBP')
                    .format('#,###,###.00 S')
                    .toString()
                    .replaceAll(regexRemoveZero, '');
                var addToCartPrice =
                    Money.fromInt(widget.product.price, code: 'GBP')
                        .format('#,###,###.00 S')
                        .toString()
                        .replaceAll(regexRemoveZero, '');

                var productVolume = widget.product.volume >= 1000
                    ? widget.product.volume / 1000
                    : widget.product.volume;
                var volumeType = widget.product.volume >= 1000
                    ? volumeTypeParserBig(widget.product.volumeType)
                    : volumeTypeParserSmall(widget.product.volumeType);
                String productInfo =
                    '${productVolume.toString().replaceAll(regexRemoveZero, '')} $volumeType';

                return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.cloud,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    child: Column(children: [
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Image.asset(
                                      widget.product.image,
                                      fit: BoxFit.cover,
                                      cacheHeight: 768,
                                      cacheWidth: 768,
                                    ))),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 10, left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.product.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(productInfo,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            softWrap: true),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Per 100 gramms',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    '${widget.product.perHundredGrams.fat}'),
                                                const Text('fat'),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              children: [
                                                Text(
                                                    '${widget.product.perHundredGrams.carbs}'),
                                                const Text('carbs')
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              children: [
                                                Text(
                                                    '${widget.product.perHundredGrams.protein}'),
                                                const Text('protein')
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              children: [
                                                Text(
                                                    '${widget.product.perHundredGrams.kcal}'),
                                                const Text('kcal')
                                              ],
                                            ),
                                          ],
                                        )
                                      ]),
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Best before, storage',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              '${widget.product.description.shelfLife}, ${widget.product.description.storageConditions}')
                                        ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Ingredients',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              widget.product.description.ingredients)
                                        ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Manufacturer, country',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.product.description.manufacturer,
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Brand',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              widget.product.description.brand)
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: AppColors.cloud,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        padding: EdgeInsets.only(
                            top: 15,
                            bottom: 10 + MediaQuery.of(context).padding.bottom,
                            left: 20,
                            right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Quantity
                            if (cartState.has(widget.product.id))
                              CustomCounter(
                                height: 53,
                                onChanged: (int quantity) {
                                  if (quantity > 0) {
                                    taskContext.addLogTask(
                                        '[NEWUI][UPDATED] Product: ${widget.product.id}, pc: $quantity');
                                    cart.updateQuantity(
                                        widget.product.id, quantity);
                                  } else {
                                    taskContext.addLogTask(
                                        '[NEWUI][REMOVED] Product: ${widget.product.id}');
                                    cart.removeFromCart(widget.product.id);
                                  }
                                },
                                quantity: cartState.count(widget.product),
                              ),
                            if (cartState.has(widget.product.id))
                              const SizedBox(width: 10),

                            // Add cart button
                            cartState.has(widget.product.id)
                                ? Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        taskContext.addLogTask(
                                            '[NEWUI][REMOVED] Product: ${widget.product.id}');
                                        cart.removeFromCart(widget.product.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.lightRed,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(34.0),
                                          ),
                                          elevation: 0,
                                          minimumSize: const Size(210, 53),
                                          textStyle: const TextStyle(fontSize: 18)),
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text('Remove '),
                                            Text(inCartPrice),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        taskContext.addLogTask(
                                            '[NEWUI][ADDED] Product: ${widget.product.id}');
                                        cart.addToCart(CartProduct(
                                            product: widget.product,
                                            quantity: 1));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.mintGreen,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(34.0),
                                          ),
                                          elevation: 0,
                                          minimumSize: const Size(210, 53),
                                          textStyle: const TextStyle(fontSize: 18)),
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text('Add to cart '),
                                            Text(addToCartPrice),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ]));
              },
            );
          },
        ));
  }
}
